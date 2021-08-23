//
//  StretchyViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit
//뷰의 헤더를 신축성 있게 표현해 보겠습니다. 아래로 스크롤링 하면 줄어들것이고 위로 스크롤링하면 늘어날것입니다.

class StretchyViewController: UIViewController {
    
    let city = [
        "서울특별시",
        "부산광역시",
        "대전광역시",
        "대구광역시",
        "인천광역시",
        "광주광역시",
        "울산광역시 ",
        "서울특별시",
        "부산광역시",
        "대전광역시",
        "대구광역시",
        "인천광역시",
        "광주광역시",
        "울산광역시 ",
        "서울특별시",
        "부산광역시",
        "대전광역시",
        "대구광역시",
        "인천광역시",
        "광주광역시",
        "울산광역시 ",
        "서울특별시",
        "부산광역시",
        "대전광역시",
        "대구광역시",
        "인천광역시",
        "광주광역시",
        "울산광역시 "
    ]
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        //navigationController?.navigationBar.isHidden = true 바를 없애고 보면 더 잘보입니다. 확인해보세유!
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        //헤더 / 이미지
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0,
                                                           width: view.width, height: view.width))
        header.imageView.image = UIImage(named: "풍경1")
        //테이블 헤더에 추가
        tableView.tableHeaderView = header
    }
    
 

}
extension StretchyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row]
        return cell
    }
    
    
    
    //StratchyHeader에서 만들었던 요소가 작동하도록 코드 작성
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: tableView)
    }
    
}
