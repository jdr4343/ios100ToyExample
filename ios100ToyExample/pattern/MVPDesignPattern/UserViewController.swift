//
//  MVPDesignViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/17.
//

import UIKit
///Model View Presenter 디자인 패턴에 대해 배울 것입니다.
class UserViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UserPresenterDelegate {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MVP")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let presenter = UserPresenter()
    private var users = [MVPUserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVPPattern"
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.setViewDelegate(delegate: self)
        presenter.getUser()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        //헤더 / 프로필 상단의 헤더에는 이미지를 나타낼것입니다.따
        let header = imageView
        imageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width*0.7)
        tableView.tableHeaderView = header
    }
    
    //MARK: tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapUser(user: users[indexPath.row])
    }
    
    //MARK: presenterDelegate
    func presentUsers(users: [MVPUserModel]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func presentAlert(title: String, message: String) {
        ///첫번쨰 방식
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
//        present(alert,animated: true)
    }
    
}
