//
//  CashingImageViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

class CashingImageViewController: UIViewController {

    let tableView: UITableView = {
        let tableViw = UITableView()
        tableViw.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        return tableViw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cash Image"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    


}

extension CashingImageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier,for: indexPath) as! ImageTableViewCell
        cell.title = "dafdsfas"
        cell.image = UIImage(named: "배경3")
        cell.badgeImage = UIImage(named: "배경2")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/2.5
    }
}

