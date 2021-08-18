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
        //CarouselTableViewCell에서 만들었던 cell을 등록하여 줍니다.
        table.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.identifier)
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
        //만든 식별자를 추가하여 주고 다운 캐스팅 해줍니다. 다운 캐스팅 같은경우 하위 클래스의 인스턴스를 참조하기 위해 사용합니다.
        //값 형식과 참조 형식은 매우 중요한 요소이니 자주자주 읽어주면서 외워주면 도움이 될꺼 같습니다.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier,
                                                 for: indexPath) as? CarouselTableViewCell else {
                                                    fatalError()
                                                 }
        
        return cell
    }
    
}
