//
//  HomeViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/31.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotAuthenticated()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = view.bounds
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
