//
//  NewConversationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import UIKit
import JGProgressHUD

//검색 결과에 대한 모델을 만듭니다.
struct SearchResult {
    let name: String
    let email: String
}

class NewConversationViewController: UIViewController {
//유저를 검색하고 새로운 대화창을 생성합니다.
    private let spinner = JGProgressHUD(style: .dark)
    
    //completion은 배열이 아닌 노드의 dictionary배열을 취하는 클로저가 될것입니다. 이 클로저는
    public var Chatcompletion: ((SearchResult) -> (Void))?
    
    //검색 결과를 가져올 배열을 생성합니다.
    private var users = [[String:String]]()
    //검색결과를 보유하는 배열입니다.
    private var results = [SearchResult]()
    
    //결과가 있는지 없는지를 확인 해주기위해 불리언값 추가
    private var hasFetched = false
    
    //사용자를 검색할수 있도록 검색바를 만들겠습니다.
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "채팅을 함께할 사람을 검색해주세요."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(NewConversationCell.self, forCellReuseIdentifier: NewConversationCell.identifier)
        return tableView
    }()
    
    //사용자가 검색 했을때 결과 값이 없다면 보여줄 라벨을 생성합니다.
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "검색 결과가 없습니다."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //네비게이션 아이템으로 상단에 검색바를 추가 해줍니다.
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "닫기",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dissmissSelf))
        navigationController?.navigationBar.tintColor = .label
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        view.addSubview(noResultLabel)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noResultLabel.frame = CGRect(x: view.width/4, y: (view.height-200)/2, width: view.width/2, height: 200)
    }
    
    @objc private func dissmissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
//MARK: - TableView

extension NewConversationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewConversationCell.identifier,
                                                 for: indexPath) as! NewConversationCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //검색을 통해 사용자를 찾았을경우 대화를 추가합니다
        let targetUserData = results[indexPath.row]
        dismiss(animated: true, completion: { [weak self] in
            self?.Chatcompletion?(targetUserData)
        })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



//MARK: - SearchBar

extension NewConversationViewController: UISearchBarDelegate {
    //검색 버튼이 클릭 됬을때를 나타내는 함수입니다. 여기에서 검색창의 텍스트를 가져오겠습니다.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //공백만 검사시 결과값을 안보여주기 위해서 추가
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        
        results.removeAll()
        spinner.show(in: view)
        
        //Firebase에 쿼리하겠습니다. 그런다음 이름 기반으로 사용자를 필터링 하겠습니다.
        self.searchUsers(query: text)
        
    }
    
    //텍스트가 있으면 검색 사용자에게 전달
    func searchUsers(query: String) {
        //파이어베이스에 저장되어있는 사용자배열에 결과가 있는지 확인합니다.
        if hasFetched {
            filterUser(with: query)
            
        } else {
            DatabaseManager.shared.getAllUsers(completion: { [weak self] result in
                switch result {
                case .success(let userCollections):
                    self?.hasFetched = true
                    self?.users = userCollections
                    self?.filterUser(with: query)
                case .failure(let error):
                    print("\(error)가 발생하여 사용자 배열을 가져오지 못했습니다.")
                }
                
            })
        }
    }
    //사용자가 있는지 확인 합니다. 그에 따른 UI를 업데이트 합니다. / 사용자 본인이 검색되지 않도록 하기위해서 이메일을 통해 제약을 추가 해줍니다.
    func filterUser(with term: String) {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String, hasFetched else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        
        self.spinner.dismiss()
        //하나의 다른 배열을 생성합니다.
        let result: [SearchResult] = self.users.filter({
            guard let email = $0["email"], email != safeEmail else {
                return false
            }
            
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(term.lowercased())
            
        }).compactMap({
            guard let email = $0["email"],
                  let name = $0["name"] else {
                return nil
            }
            return SearchResult(name: name, email: email)
        })
        
        self.results = result
        
        updateUI()
    }
    func updateUI() {
        if results.isEmpty {
            self.noResultLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.noResultLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}


