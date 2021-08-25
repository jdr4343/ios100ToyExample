//
//  ProfileViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit
///프로필 화면 입니다.
class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        configureNavigationBar()
    

    }
    
    //네비게이션 아이템 추가
    private func configureNavigationBar() {
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
