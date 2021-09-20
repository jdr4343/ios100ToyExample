//
//  ProfileViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit
import FirebaseAuth
//프로필 화면 입니다.
///참고자료: 테이블뷰, 테이블뷰 헤더와 푸터, 늘어나고 줄어드는 신축성 테이블뷰
class ProfileViewController: UIViewController,ProfileInfoHeaderTableHeaderViewDelegate {
   

    //테이블뷰를 생성합니다.
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(PostPreViewTableViewCell.self, forCellReuseIdentifier: PostPreViewTableViewCell.identifier)
        return table
    }()
    
    //테이블 게시물 화면
    private var posts: [BlogPost] = []
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationController?.navigationBar.tintColor = .label
        addconfigureNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        self.tableView.alwaysBounceVertical = false
        tableView.bounces = true
        NotAuthenticated()
        fetchPosts()
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //헤더 / 프로필 상단의 헤더에는 프로필을 나타낼것입니다.따로 헤더를 위한 뷰를 만들어서 연결 하겠습니다 /그리고 만든 헤더에 우리가 만든 델리게이트를 연결 하겠습니다.
        let header = ProfileInfoHeaderTableHeaderView(frame: CGRect(x: 0, y: 0,
                                                                    width: view.width, height: view.width*1.5))
        tableView.tableHeaderView = header
        header.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - 구현대기 /홈을 메인뷰로 바뀌어서 홈화면이 제일 먼저 뜨게 된다면 지울것입니다 지울것입니다.
    
    // 사용자가 로그인 하지 않았다면 로그인 화면을 보여주고 아니라면 메인 뷰를 보여줄것입니다.
    private func NotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
    
    //MARK: - Add
    
    //네비게이션 아이템 추가
    private func addconfigureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTabSettingButton))
    }
    @objc func didTabSettingButton() {
        let vc = SettingViewController()
        vc.title = "설정"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - ProfileInfoHeaderTableHeaderViewDelegate / 구현대기
   
    func didTapPostButton() {
        print("게시물 생성화면을 연결하겠습니다.")
    }
    
    func didTapEditProfileButton() {
        let vc = EditProfileViewController()
        vc.title = "프로필 변경"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - 게시물
    private func fetchPosts() {
        //오류 포스트관련 오류 발생시 여기 관련 확인
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        //데이터베이스에게 이메일 전달
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        DatabaseManager.shared.getPosts(for: safeEmail) { [weak self] posts in
            self?.posts = posts
            print("\(posts.count)개의 게시물이 존재 합니다.")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreViewTableViewCell.identifier, for: indexPath) as? PostPreViewTableViewCell else {
            fatalError()
        }
        cell.configure(with: .init(title: post.title, imageUrl: post.headerImageUrl))
       
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
        return 100
    }
    
    //MARK: - Header
    
    
   
    
    
    
    
}


