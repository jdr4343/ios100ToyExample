//
//  asdfViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/10/01.
//

import UIKit

class asdfViewController: UIViewController {
    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
    


    lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.progressImage = UIImage(named: "항목컬러")
        progress.trackImage = UIImage(named: "항목메인")
        progress.layer.shadowColor = UIColor.label.cgColor
        progress.layer.shadowOpacity = 0.3
        progress.layer.shadowOffset = CGSize(width: 2, height: 3)
        progress.setProgress(0.7, animated: true)
        return progress
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(progress)
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progress.frame = view.bounds
        progress.center = view.center
        progress.transform = progress.transform.scaledBy(x: 1, y: 2)
    }
    
    
    
}

//extension asdfViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        return cell
//    }
//
//}
