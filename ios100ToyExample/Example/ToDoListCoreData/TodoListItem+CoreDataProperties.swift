//
//  TodoListItem+CoreDataProperties.swift
//  
//
//  Created by 신지훈 on 2021/09/16.
//
//

import Foundation
import CoreData


extension TodoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createAt: Date?
    //isChecked는 홈뷰에서 사용하기 위해 작성했습니다.
    @NSManaged public var isChecked: Bool?



}
