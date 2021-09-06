//
//  ConversationsViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/31.
//

import UIKit
import JGProgressHUD

//노드의 conversations를 가져옵니다.
struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}

class ConversationsViewController: UIViewController {

    //대화 모델
    private var conversations = [Conversation]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.identifier)
        //현재 로그인한 사용자에 대한 대화를 가져오고 대화가 없는 경우에 가져오지 않기 위해서 isHidden 속성을 추가 해줍니다.
        tableView.isHidden = true
        return tableView
    }()
    
    //대화가 없을경우 보여줄 라벨
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "대화 목록이 없습니다."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    //대화를 가저오는 동안 보여줄 스피너를 추가 하여 줍니다.
    private let spinner: JGProgressHUD = {
        let spinner = JGProgressHUD(style: .dark)
        spinner.textLabel.text = "Loading"
        //spinner.show(in: tableview)
        spinner.dismiss(afterDelay: 1)
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        //사용자가 새 대화를 추가 할수 있도록 네비게이션 바 아이템 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapComposeButton))
        tableView.delegate = self
        tableView.dataSource = self
        fetchConversations()
        startListeningForConversations()
    }
    override func viewDidAppear(_ animated: Bool) {
        //구현대기 /탭바가 너무 형편없이 사라져서 애니메이션을 추가 해줘야 할거 같음 우선은 그냥 내비두고 모든구현을 끝내고 돌아와서 만들자!
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //데이터베이스의 해당 배열에 리스너를 연결하는 함수를 만들고 새 대화가 추가될때 마다 기본적으로 테이블을 업데이트 하겠습니다.
    private func startListeningForConversations() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        print("대화를 불러옵니다")
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        DatabaseManager.shared.getAllConversations(for: safeEmail, completion: { [weak self] result in
            switch result {
            case .success(let conversations):
                print("성공적으로 대화를 불러왔습니다.")
                guard !conversations.isEmpty else {
                    return
              }
                self?.conversations = conversations
                
                //새로운 대화를 할당
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("대화를 얻는데 실패 했습니다 - \(error)")
            }
        })
    }

    
    //대화를 가져오겠습니다
    private func fetchConversations() {
        tableView.isHidden = false
    }
    //대화창을 연결합니다. /새 대화를 생성하고 해당 결과를 보내서 알맞은 사람과 대화 할수 있도록 합니다.
    @objc private func didTapComposeButton() {
        let vc = NewConversationViewController()
        vc.Chatcompletion = { [weak self] result in
            //result는 옆의 유형처럼 전달되서 구분 가능하게 해줍니다. ["name": "아이유", "email": "IU-naver-com"]
            self?.createNewConversation(result: result)
        }
        let nvc = UINavigationController(rootViewController: vc)
        present(nvc, animated: true)
    }
    private func createNewConversation(result: [String: String]) {
        //result의 결과를 토대로 구분하고 대화하고 있는 상대를 알수 있도록 title을 바꿔줍니다..
        guard let name = result["name"], let email = result["email"] else {
            return
        }
        let vc = ChatViewController(with: email)
        //새로운 대화임을 알립니다.
        vc.isNewConversation = true
        vc.title = name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - TableView

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = conversations[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.identifier, for: indexPath) as! ConversationTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = conversations[indexPath.row]
        let vc = ChatViewController(with: model.otherUserEmail)
        vc.title = model.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
