//
//  Person+CoreDataProperties.swift
//  
//
//  Created by 신지훈 on 2021/09/25.
//
//

import Foundation
import CoreData

///클래스의 확장 파일 입니다. 따라서 위의 두파일을 결합한 것이 새로운 사람모델이라고 생각하면 됩니다.
extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    ///모델의 종류라고 생각하고 유형이 저장되어 있습니다. 
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int64

}
