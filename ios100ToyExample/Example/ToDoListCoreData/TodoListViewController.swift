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
    
    var models = [TodoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "할일 목록"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        getAllData()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "할일", message: "할일을 추가 하시겠습니까?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "추가", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first,let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
           
        }))
        present(alert, animated: true)
    }
    
    
    //MARK: CoreDAta
    
    ///모든 항목 데이터를 가져옵니다.
    func getAllData() {
        do {
            models = try context.fetch(TodoListItem.fetchRequest())
            tableView.reloadData()
        } catch {
            //error
        }
    }
    ///항목을 생성하고 변경사항을 저장 합니다.
    func createItem(name: String) {
        let newItem = TodoListItem(context: context)
        newItem.name = name
        newItem.createAt = Date()
        do {
            try context.save()
            getAllData()
        } catch {
            
        }
    }
    
    ///항목을 삭제하고 변경사항을 저장 합니다.
    func deleteItem(item: TodoListItem) {
        context.delete(item)
        do {
            try context.save()
            getAllData()
        } catch {
            
        }
    }
    ///항목을 업데이트 하고 변경사항을 저장합니다.
    func updateItem(item: TodoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllData()
        } catch {
            
        }
    }
    

}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
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
        let sheet = UIAlertController(title: "변경", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "변경", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "항목 변경", message: "변경 하시겠습니까?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "추가", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first,let newName = field.text, !newName.isEmpty else {
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
