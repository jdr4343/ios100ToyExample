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
    
    private var loginObserver: NSObjectProtocol?
    
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
        
        //채팅이 바로 업데이트 되도록 추가
        loginObserver = NotificationCenter.default.addObserver(forName: .didLogInNotification, object: nil, queue: .main, using: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.startListeningForConversations()
        })
        
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
        //채팅 업데이트
        if let observer = loginObserver {
            NotificationCenter.default.removeObserver(observer)
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
            guard let strongSelf = self else {
                return
            }
            //검색시 이미 진행중인 대화가 있다면 그 대화와 연결합니다.
            let currentConversations = strongSelf.conversations
            
            if let targetConversation = currentConversations.first(where: {
                $0.otherUserEmail == DatabaseManager.safeEmail(emailAddress: result.email)
            }) {
                let vc = ChatViewController(with: targetConversation.otherUserEmail, id: targetConversation.id)
                //새로운 대화가 아님을 알립니다.
                vc.isNewConversation = false
                vc.title = targetConversation.name
                vc.navigationItem.largeTitleDisplayMode = .never
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            } else {
                //새대화를 생성합니다. / result는 옆의 유형처럼 전달되서 구분 가능하게 해줍니다. ["name": "아이유", "email": "IU-naver-com"]
                strongSelf.createNewConversation(result: result)
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        present(nvc, animated: true)
    }
    
    private func createNewConversation(result: SearchResult) {
        //result의 결과를 토대로 구분하고 대화하고 있는 상대를 알수 있도록 title을 바꿔줍니다..
        let name = result.name
        let email = DatabaseManager.safeEmail(emailAddress: result.email)
        
        //두 사용자와의 대화가 존재하는 경우 (데이터베이스)를 체크합니다.
        //이렇게 연결하여 주는 이유는 위에서 한 사용자가 대화 항목을 지우고 대화를 지운 사람이 새 대화를 만들경우 두 사용자간의 중복 대화가 생기는 걸 방지하기 위합입니다.
        //존재한다면 conversationId 를 재사용합니다.
        //그렇지 않다면 기존 코드를 사용합니다.
        DatabaseManager.shared.conversationExists(with: email, completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let conversationId):
                //진행중인 대화 데이터베이스 항목이 있으므로 두 사용자의 대화를 연결 합니다.
                let vc = ChatViewController(with: email, id: conversationId)
                //새로운 대화가 아님을 알립니다.
                vc.isNewConversation = false
                vc.title = name
                vc.navigationItem.largeTitleDisplayMode = .never
                strongSelf.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(_):
                //진행중인 대화 데이터베이스 항목이 없으므로 대화를 생성합니다.
                let vc = ChatViewController(with: email, id: nil)
                //새로운 대화임을 알립니다.
                vc.isNewConversation = true
                vc.title = name
                vc.navigationItem.largeTitleDisplayMode = .never
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
}//메시지에서 대화생성 날짜 이후보다 날짜가 더 큰 메시지만 표시하도록 하겠습니다. 그 이유는 대화 목록을 지웠음에도 상대방에게 대화목록이 남아 있다면 표시되기 때문입니다.

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
        openConversation(model)
    }
     
    func openConversation(_ model: Conversation) {
        let vc = ChatViewController(with: model.otherUserEmail, id: model.id)
        vc.title = model.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - 대화 목록 삭제
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //행을 삭제
            let conversationId = conversations[indexPath.row].id
            tableView.beginUpdates()
            //데이터베이스에서 만든 함수를 연결하여줍니다. //행을 삭제한후 모델 업데이트
            DatabaseManager.shared.deleteConverstion(conversationId: conversationId, completion: { [weak self] success in
                if success {
                    self?.conversations.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            })
            
            tableView.endUpdates()
        }
      
        
    }
}
