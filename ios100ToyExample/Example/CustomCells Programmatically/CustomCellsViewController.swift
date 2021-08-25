//
//  CustomCellsViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit

class CustomCellsViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}
extension CustomCellsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //다운 캐스팅하여 configure 함수에 접근하고 자동으로 숫자가 추가 되도록 하여줍니다.이미지는 삼항연산자를 추가하여 번갈아가면 이미지가 나오도록 했습니다. % 결과 값이 0 이라면 참으로 판단되 food1이 나오고 false의 경우에는 food3이 출력될것입니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for:indexPath) as? CustomTableViewCell else {
                                                    return UITableViewCell()
                                                 }
        cell.configure(text: "커스텀 셀 + \(indexPath.row)",
                        imageName: indexPath.row % 2 == 0 ? "food1" : "food3")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
