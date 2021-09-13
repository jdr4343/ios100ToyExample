//
//  HomeViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/31.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeWidzetTableViewCell.self, forCellReuseIdentifier: HomeWidzetTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.isHidden = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotAuthenticated()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame  = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //헤더 / 프로필 상단의 헤더에는 프로필을 나타낼것입니다.따로 헤더를 위한 뷰를 만들어서 연결 하겠습니다 /그리고 만든 헤더에 우리가 만든 델리게이트를 연결 하겠습니다.
        let header = HomeHeaderViewController(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width*0.7))
        tableView.tableHeaderView = header
       // header.delegate = self
    }
    
    // 사용자가 로그인 하지 않았다면 로그인 화면을 보여주고 아니라면 메인 뷰를 보여줄것입니다.
    private func NotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeWidzetTableViewCell.identifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/3.5
    }
    
}
