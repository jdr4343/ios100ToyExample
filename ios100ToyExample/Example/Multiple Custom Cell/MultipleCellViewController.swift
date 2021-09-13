//
//  MultipleCellViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/13.
//

import UIKit

//여러개의 셀을 한 테이블뷰에서 작업하는 방법에 대해 배웁니다.
class MultipleCellViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        //코드
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.identifier)
        //UInib
        tableView.register(SecondTableViewCell.nib(), forCellReuseIdentifier: SecondTableViewCell.identifier)
        tableView.register(ThirdTableViewCell.self, forCellReuseIdentifier: ThirdTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension MultipleCellViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 5 {
            //5번째 행 까지 FirestTableViewCell을 보여준다고 제약을 걸어줍니다.
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier,for: indexPath)
            cell.textLabel?.text = "HELLO WOLED"
            return cell
            
        }
        if indexPath.row < 10 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else {
                return UITableViewCell()
            }
            //SecondTableViewCell를 다운캐스팅해서 만든 configure 함수를 통해 이미지를 전달해 줍니다.
            cell.configure(with: "애플로고")
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCell.identifier, for: indexPath) as? ThirdTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: "무슨배경", text: "오늘은 찜닭을 먹었습니다. 행복하군요")
        return cell
    }
  
    //셀의 높이를 정하여 줍니다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 5 {
            return 50
        }
        if indexPath.row < 10 {
            return 150
        }
            return 100
    }
    
}
