//
//  MVVMEventViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import UIKit

struct UserListViewModel {
    //사용자를 담을 빈 배열을 만들어 줍니다.
    public var users: [TestUser] = []
    
    
    ///데이터를 가져오는 함수입니다 모의 데이터가 연결되어 있는 URL입니다.
    public func fetchUserList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        //API호출을 내보냅니다
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            //이벤트 선언
            let event: UserFetchEvent
            
            do {
                //사용자 배열을 디코딩 합니다. 디코딩은 인코딩의 반댓말로 사람이 이해할수 없는 컴퓨터 언어를 사람이 이해할수 있도록 바꾸는 것 입니다.
                let users = try JSONDecoder().decode([TestUser].self, from: data)
                
                //사용자를 가져오기 이벤트를 인스턴스화 합니다. //사용자를 가져오는데 성공 했다면 사용자 배열을 생성합니다.
                event = UserFetchEvent(identifier: UUID().uuidString,
                                           result: .success(users))
            }
            catch {
                //실패
                print(error)
                event = UserFetchEvent(identifier: UUID().uuidString,
                                           result: .failure(error))
            }
            //사용자 가져오기 이벤트를 실행 합니다.
            Bus.shared.publish(type: .userFetch, event: event)
            
        }
        //진행하라고 명령을 내려줍니다.
        task.resume()
    }

}

//MVME Pattern을 알아봅니다.
class MVVMEventViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MVVM")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //모델을 뷰와 연결 해 줍니다.
    private var viewModel = UserListViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        title = "MVVMPattern"
        navigationItem.largeTitleDisplayMode = .always
        //Bus를 통해 뷰 모델의 이벤트에 테이블 뷰를 바인딩 합니다.
        Bus.shared.subscribeOnMain(.userFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let users):
                self?.viewModel.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        //데이터를 가져옵니다.
        viewModel.fetchUserList()
    }
    override func viewWillAppear(_ animated: Bool) {
        //헤더 / 프로필 상단의 헤더에는 이미지를 나타낼것입니다.따
        let header = imageView
        imageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width*0.7)
        tableView.tableHeaderView = header
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
        
}

extension MVVMEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users[indexPath.row].name
        return cell
    }
    
    
}
