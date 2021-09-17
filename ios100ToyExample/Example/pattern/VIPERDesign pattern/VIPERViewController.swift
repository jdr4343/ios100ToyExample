//
//  VIPERViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

class VIPERViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "VIPER")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //헤더 / 프로필 상단의 헤더에는 이미지를 나타낼것입니다.따
        let header = imageView
        imageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width*0.7)
        //tableView.tableHeaderView = header
    }
    
}
