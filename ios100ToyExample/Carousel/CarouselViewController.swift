//
//  CarouselCallectionViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class CarouselViewController: UIViewController,UITableViewDataSource {
    

    let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .white
        //셀추가
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "셀이 등록되었습니다."
        return cell
    }
    
}
