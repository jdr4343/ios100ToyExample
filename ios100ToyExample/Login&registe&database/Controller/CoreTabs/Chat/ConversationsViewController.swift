//
//  ConversationsViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/31.
//

import UIKit
import JGProgressHUD

class ConversationsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //현재 로그인한 사용자에 대한 대화를 가져오고 대화가 없는 경우에 가져오지 않기 위해서 isHidden 속성을 추가 해줍니다.
        tableView.isHidden = true
        return tableView
    }()
    
    //대화가 없을경우 보여줄 라벨
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversations"
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
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //구현대기 /탭바가 너무 형편없이 사라져서 애니메이션을 추가 해줘야 할거 같음 우선은 그냥 내비두고 모든구현을 끝내고 돌아와서 만들자!
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
        vc.title = name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - TableView

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "테스트"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ///구현 대기 / 챗뷰를 만들고 지울것
        let vc = ChatViewController()
        vc.title = "Test People"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
