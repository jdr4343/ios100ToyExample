//
//  TodoDatabase.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/25.
//

import Foundation
import CoreData
import UIKit

final class TodoDatabase {
    
    static let shared  = TodoDatabase()
    
    private init() {}
    
    var models = [TodoListItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //MARK: CoreDAta
    
    ///모든 항목 데이터를 가져옵니다.
    func getAllData() {
        do {
            models = try context.fetch(TodoListItem.fetchRequest())
        } catch {
            //error
        }
    }
    ///항목을 생성하고 변경사항을 저장 합니다.
    func createItem(name: String) {
        let newItem = TodoListItem(context: context)
        newItem.name = name
        newItem.createAt = Date()
        
        models.insert(newItem, at: 0)
        do {
            try context.save()
            getAllData()
            print(models)
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
