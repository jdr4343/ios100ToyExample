//
//  TodoListViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class TodoListViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    static let newTodoDidInsert = Notification.Name(rawValue: "newTodoDidInsert")
    //라디오 방송국의 주파수 라고 생각하면 됨 라디오는 주파수로 구분하지만 노티는 이름으로 구분함
    static let todoDidChange = Notification.Name("todoDidChange")
    
    var token: NSObjectProtocol?

    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
            tableView.reloadData()
        }
        //이제 저장 기능이 완성 되었습니다.
    }
    
    
   // var models = [TodoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "할일 목록"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        //getAllData()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TodoDatabase.shared.getAllData()
        tableView.reloadData()
    }
    
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "할일", message: "할일을 추가 하시겠습니까?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "추가", style: .cancel, handler: {  _ in
            guard let field = alert.textFields?.first,let text = field.text, !text.isEmpty else {
                return
            }
            TodoDatabase.shared.createItem(name: text)
            
            
        }))
        present(alert, animated: true)
    }
    
    
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoDatabase.shared.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = TodoDatabase.shared.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = TodoDatabase.shared.models[indexPath.row]
        let sheet = UIAlertController(title: "변경", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "변경", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "항목 변경", message: "변경 하시겠습니까?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "추가", style: .cancel, handler: {  _ in
                guard let field = alert.textFields?.first,let newName = field.text, !newName.isEmpty else {
                    return
                }
                TodoDatabase.shared.updateItem(item: item, newName: newName)
                

            }))
            self.present(alert, animated: true)

        }))
        sheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: {  _ in
           
            TodoDatabase.shared.deleteItem(item: item)
            
           
        }))
        
        present(sheet, animated: true)
        
    }
    
}
