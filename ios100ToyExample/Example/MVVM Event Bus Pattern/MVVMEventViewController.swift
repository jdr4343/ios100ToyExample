//
//  MVVMEventViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import UIKit



class MVVMEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

      
    }
    
    ///데이터를 가져오는 함수입니다 모의 데이터가 연결되어 있는 URL입니다.
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
    }

   
}
