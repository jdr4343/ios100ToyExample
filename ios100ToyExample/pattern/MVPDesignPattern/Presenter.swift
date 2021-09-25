//
//  File.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/17.
//

import Foundation
import UIKit
///API응답을 얻기 위한 사용자 목록 URL
///"https://jsonplaceholder.typicode.com/users"

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [MVPUserModel])
    func presentAlert(title: String, message: String)
}

typealias PresentetDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    weak var delegate: PresentetDelegate?
    
    public func getUser() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode([MVPUserModel].self, from: data)
                self?.delegate?.presentUsers(users: users)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresentetDelegate) {
        self.delegate = delegate
    }
    
    public func didTapUser(user: MVPUserModel) {
        ///첫번쨰 방식
       // delegate?.presentAlert(title: user.name, message: "\(user.name)님의 이메일은 \(user.email) & 닉네임은 \(user.username) 입니다.")
        ///두번쨰 방식
        let title = user.name
        let message = "\(user.name)님의 이메일은 \(user.email) & 닉네임은 \(user.username) 입니다."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        delegate?.present(alert,animated: true)
    }
    
   
}
