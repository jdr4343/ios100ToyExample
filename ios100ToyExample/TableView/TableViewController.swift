//
//  TableViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    //MARK: - 테이블 뷰 기능 구현
    //테이블뷰의 셀의 행수를 정합니다. 2를 반환 하면 2개의 행이 있을것이고 10개를 리턴하면 10개의 셀이 있을것 입니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)번째 셀을 생성했습니다."
        return cell
    }
    //셀의 선택했을때의 기능을 구현합니다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row)번째 셀을 선택했습니다.")
    }

}
