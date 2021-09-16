//
//  ToDoListViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class ToDoListViewController: UIViewController {

   private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [TodoListItem]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "할일 목록"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        view.addSubview(tableView)
        getAllitems()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func didTapAdd() {
        
        let alert = UIAlertController(title: "새로운 할일", message: "할일을 추가해주세요", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "추가", style: .cancel, handler: { [weak self]  _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItme(name: text)
        }))
        present(alert, animated: true)
    }
   
    //MARK: - Core Data
    
    ///모든 항목을 가져옵니다.
    func getAllitems() {
        do {
            models = try context.fetch(TodoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            //error
        }
    }
    
    ///항목을 생성하고 저장합니다.
    func createItme(name: String) {
        let newItem = TodoListItem(context:  context)
        newItem.name = name
        newItem.createAt = Date()
        do {
            try context.save()
            getAllitems()
        } catch {
            //error
        }
    }
    
    ///항목을 삭제하고 저장합니다.
    func deleteItem(item: TodoListItem) {
        context.delete(item)
        do {
            try context.save()
            getAllitems()
        } catch {
            //error
        }
    }
    
    ///항목을 업데이트 합니다
    func updateItem(item: TodoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllitems()
        } catch {
            //error
        }
    }
}

//MARK: - Table View

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "편집", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "편집", style: .default, handler: { _ in
            let alert = UIAlertController(title: "내용을 변경합니다.", message: "내용을 변경해주시요", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "저장", style: .cancel, handler: { [weak self]  _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newName)
            }))
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
            
            
        
        present(sheet, animated: true)
    }
}
