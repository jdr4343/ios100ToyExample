//
//  ExampleViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit

class ExampleViewController: UIViewController {

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as? ExampleTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "여기에 예제뷰를 만든다"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
