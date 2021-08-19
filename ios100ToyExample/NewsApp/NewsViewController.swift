//
//  NewsViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

//뉴스 api를 가져와 뉴스 앱을 만들어 보겠습니다.
//api는 newsapi.org에서 받아 올수 있습니다. 받아온 api를 복사하여 APICaller에 저장해주시면 됩니다.
import UIKit

class NewsViewController: UIViewController {
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        //APi호출이 작동되는지 확인
        APICaller.shared.getTopStories(complation: { result in
            switch result {
            case .success(let response):
                break
            case . failure(let error):
                print(error)
                
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "fasf"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
