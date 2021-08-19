//
//  UIViewController+Alert.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import UIKit
//경고창
extension UIViewController {
    func alert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        //present   메소드를 활용해서 경고창을 화면에 표시
    }
}

