//
//  DataManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//


import Foundation
import CoreData

class DataManager {// 싱글톤으로 구현
    //Mark: - Core Data Stack
    static let shared = DataManager()
    //공유 인스턴스를 저장할 타입 프로퍼티
    private init() {//기본 생성자를 추가하고 pricate로 선언
        //이렇게 하면 앱전체에서 하나의 인스턴스를 공유 할수 있음.
        //Singleton 싱글톤
    }
    var mainContenxt: NSManagedObjectContext {
        return persistentContainer.viewContext
        //코어 데이터에서 실행하는 대부분의 작업은 Contenxt객체가 담당합니다. 직접 만들수도 있지만 기본적으로 제공되는 Contenxt 를 사용하겠습니다.
    }
    //메모를 데이터 베이스에에서 읽어오는 코드를 구현하겠습니다.우선 메모를 저장할 배열을 선언하고 빈배열로 초기화 하겠습니다.
    var memoList = [Memo]()
    
    func fetchMemo() {
        //데이터를 데이터 베이스에서 읽어오는 다양한 용어가 있습니다. ios에서는 이것을 fetch라고 합니다. 데이터 베이스에서 데이터를 읽어올때는 먼저 fetch request를 만들어야 합니다.
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        //코어데이터가 리턴해주는 데이터는 기본적으로 정렬되어 있지 않습니다. 그래서 SortDescriptor를 만든다음에 우리가 원하는 방식으로 정렬해야 합니다.여기에서는 최근 메모가 정렬되도록 날짜를 내림차순으로 정렬하겠습니다.
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        //이제 fetchRequest 실행하고 데이터를 가져오는 코드만 남았습니다.
        do {
        memoList = try mainContenxt.fetch(request)// 이렇게 do 블럭에 추가 해준다음에 앞에 try 키워드를 추가 해줘야합니다. catch메소드가 리턴하는 결과는 MemoList배열에 저장 하겠습니다.
            
          //이렇게 하면 데이터 베이스에 저장되어 있는 메모가 날짜를 기준으로 내림차순정렬된 다음에 최종 결과가 memoList배열에 저장됩니다.
            
        //fetchRequest 사용할때는 Contenxt 객체가 제공하는 fetch 메소드를 사용합니다.그런데 자동완성을 보면 뒤쪽에 throw 키워드가 있습니다. 이런 메소드는 실행했을떄 예외가 발생할수 있다는 뜻입니다.그래서 일반메소드 처럼 호출하면 에러가 발생합니다. Do catch블럭을 사용해서 호출해야 합니다.
        } catch {
          print(error)
        }
    }
    //데이터를 읽어오는 코드는 완성 되었습니다.이제 TableView가 memoList배열에 저장되어 있는 메모를 표시하도록 수정 하겠습니다.
    
    func addNewMemo(_ memo: String?) {
        let newMemo = Memo(context: mainContenxt) // 메모 인스턴스 코어데이터가 만들어준 클래스입니다.그래서 새로운 인스턴스를 만들떄 생성자로 contenxt를 전달해야 합니다.
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        memoList.insert(newMemo, at: 0)
        //이렇게 배열 가장 앞부분에 새로운 메모를 추가하면 캐치메모 메소드를 다시 호출 한것과 동일한 결과를 얻을수 있습니다.불필요한 데이터 베이스 작업이 생략되기 떄문에 조금더 효율적 입니다.
        saveContext()
    }
    
    //삭제 메소드 구현: 파라미터를 옵셔널로 선언하고 실제로 메모가 전달된 경우에만 삭제 해보겠습니다.
    func deleteMemo(_ memo:Memo?) {
        if let memo = memo {
            mainContenxt.delete(memo)
            saveContext()
            //contenxt제공하는 delete 메소드를 호출한다음 context를 저장하면 실제로 메모가 삭제 됩니다.
        }
    }
    
    //Mark - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ios100ToyExample")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Mark - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
}

