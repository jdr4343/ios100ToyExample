//
//  CashingImageViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

//API를 통해 이미지를 다운로드 받고 그 이미지를 스크롤 할떄 다시 다운로드 되지 않도록 캐시 하겠습니다.


class CashingImageViewController: UIViewController {

    let network = NetworkManger.shared
    
    var posts: [Post] = []
    
    
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
        
        network.posts(query: "Fashion") { [weak self] posts, error in
            if let error = error {
                print("에러 = \(error)")
                return
            }
            self?.posts = posts!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    


}

extension CashingImageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier,for: indexPath) as! ImageTableViewCell
        cell.title = post.description
        
        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "picture")
        }
        
        network.image(post: post) { data, error in
            if let data = data {
                let image = image(data: data)
                DispatchQueue.main.async {
                    cell.image = image
                }
            }
        }
        network.profileImage(post: post) { data, error in
            if let data = data {
                let image = image(data: data)
                DispatchQueue.main.async {
                    cell.badgeImage = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/2.5
    }
}

