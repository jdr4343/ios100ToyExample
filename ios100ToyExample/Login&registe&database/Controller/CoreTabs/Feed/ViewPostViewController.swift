//
//  ViewPostViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/19.
//

import UIKit

class ViewPostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
    private let post: BlogPost
    
    init(post: BlogPost) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let tableView: UITableView = {
        ///title,header.body
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //title, image, body
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            cell.textLabel?.text = post.title
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostHeaderTableViewCell.identifier,for: indexPath) as? PostHeaderTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.configure(with: .init(imageUrl: post.headerImageUrl))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.text
            return cell
        default:
            fatalError()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 200
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    

    

}
