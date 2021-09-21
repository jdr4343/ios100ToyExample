//
//  FeedViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/19.
//

import UIKit

class FeedViewController: UIViewController {

    private var posts: [BlogPost] = []
    
    private let composeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)),
                        for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(PostPreViewTableViewCell.self, forCellReuseIdentifier: PostPreViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchAllPosts()
        refreshController()
        view.addSubview(tableView)
        view.addSubview(composeButton)
        tableView.delegate = self
        tableView.dataSource = self
        composeButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        composeButton.frame = CGRect(x: view.frame.width-60-16, y: view.frame.height-60-16-view.safeAreaInsets.bottom, width: 60, height: 60)
        tableView.frame = view.bounds
    }

    @objc func didTapCreate() {
        let vc = CreaateNewPostViewController()
        vc.title = "게시물 작성"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }

    //MARK: - 게시물
    private func fetchAllPosts() {
        print("피드를 패칭합니다.")
        DatabaseManager.shared.getAllPost { [weak self] posts in
            self?.posts = posts
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }
    
    private func refreshController() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPost), for: .valueChanged)
    }
    @objc private func refreshPost() {
        fetchAllPosts()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }


}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreViewTableViewCell.identifier, for: indexPath) as? PostPreViewTableViewCell else {
            fatalError()
        }
        cell.configure(with: .init(title: post.title, body: post.text, imageUrl: post.headerImageUrl))
       
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewPostViewController(post: posts[indexPath.row])
        vc.title = "post"
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
        print("did Tap\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}
