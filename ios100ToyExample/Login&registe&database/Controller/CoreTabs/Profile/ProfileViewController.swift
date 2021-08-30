//
//  ProfileViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit
///프로필 화면 입니다.
class ProfileViewController: UIViewController {

    //컬렉션뷰를 생성합니다.
    private var tableView: UITableView = {
        let table = UITableView()
        //헤더 / 프로필 상단의 헤더에는 프로필을 나타낼것입니다.따로 헤더 뷰를 만들어서 연결 하겠습니다
        table.register(ProfileInfoHeaderTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileInfoHeaderTableHeaderView.identifier)
        //셀
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //모델과 연결합니다.
    private var userPost = [UserPost]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        addconfigureNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    
    //MARK: - Add
    
    //네비게이션 아이템 추가
    private func addconfigureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTabSettingButton))
    }
    @objc func didTabSettingButton() {
        let vc = SettingViewController()
        vc.title = "설정"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "><"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileInfoHeaderTableHeaderView.identifier)
        return header
    }
    //헤더 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 500
    }
    
}
