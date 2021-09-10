//
//  ExampleViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit

class ExampleViewController: UIViewController {
    
    
    private var viewModels = [[ExampleTableViewCellModel]]()
    
    private func configureModels() {
        //첫번쨰 섹션
        viewModels.append([ExampleTableViewCellModel(title: "예제파일", viewModels:
          [ExampleCollectionViewModel(name: "1번 예제",
                                     backgroundImage: UIImage(named: "food1"), handle: {
                                      print("1")
          }),
           ExampleCollectionViewModel(name: "2번 예제",
                                     backgroundImage: UIImage(named: "food2"), handle: {
                                      print("2")
          }),
           ExampleCollectionViewModel(name: "3번 예제",
                                       backgroundImage: UIImage(named: "food3"), handle: {
                                      print("3")
                                        
                                       })
          ])])
        //두번째 섹션
        viewModels.append([ExampleTableViewCellModel(title: "뷰 활용", viewModels:
          [ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food4"), handle: {
                                      print("1")
          }),
           ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food5"), handle: {
                                      print("2")
          }),
           ExampleCollectionViewModel(name: "",
                                       backgroundImage: UIImage(named: "food6"), handle: {
                                      print("3")
                                       })
          ])])
        //세번째 섹션
        viewModels.append([ExampleTableViewCellModel(title: "프레임 워크", viewModels:
          [ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food1"), handle: {
                                      print("1")
          }),
           ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food1"), handle: {
                                      print("2")
          }),
           ExampleCollectionViewModel(name: "",
                                       backgroundImage: UIImage(named: "food1"), handle: {
                                      print("3")
                                       })
          ])])
        
        viewModels.append([ExampleTableViewCellModel(title: "간단앱", viewModels:
          [ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food1"), handle: {
                                      print("1")
          }),
           ExampleCollectionViewModel(name: "",
                                     backgroundImage: UIImage(named: "food1"), handle: {
                                      print("2")
          }),
           ExampleCollectionViewModel(name: "",
                                       backgroundImage: UIImage(named: "food1"), handle: {
                                      print("3")
                                       })
          ])])
        
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "예제"
        configureModels()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as? ExampleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: viewModel)
        //구현이 안된다면 찾아올것
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/3
    }
}
