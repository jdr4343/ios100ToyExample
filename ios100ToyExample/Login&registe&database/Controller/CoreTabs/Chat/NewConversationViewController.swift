//
//  NewConversationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    
    //사용자를 검색할수 있도록 검색바를 만들겠습니다.
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "채팅을 함께할 사람을 검색해주세요."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        searchBar.becomeFirstResponder()
    }
    
    @objc private func dissmissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension NewConversationViewController: UISearchBarDelegate {
    //검색 버튼이 클릭 됬을때를 나타내는 함수입니다.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
