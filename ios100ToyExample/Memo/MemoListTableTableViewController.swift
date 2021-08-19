//
//  MemoListTableTableViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//
import UIKit

class MemoListTableViewController: UITableViewController {
    
    let formatter: DateFormatter = {
       let f = DateFormatter ()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "ko_kr")
        return f
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)//이름처럼 뷰 컨트롤러가 관리하는 뷰가 화면에 표시되기 직전에 자동으로 호출됩니다.여기에서 테이블 뷰에게 목록을 업데이트 하라고 알려줍니다.
        
        DataManager.shared.fetchMemo()//여기에서 fetchMemo가 호출되면 배열이 데이터로 채워집니다.
        tableView.reloadData()//이어서 리로드 데이터 메소드가 호출되면 배열에 저장된 데이터를 기반으로 테이블 뷰가 업데이트 됩니다.
        
        //fetch 메모 메소드를 호출하고 바로 이어서 테이블 뷰에서 리로드 데이터 메소드를 호출하겠습니다
       // tableView.reloadData()//reloadData 메소드를 호출하면 데이터소스가 전달해주는 최신 데이터로 업데이트 합니다.
       // print(#function)
    }
    //Observer 해제
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
        //이제 저장 기능이 완성 되었습니다.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //스토리보드의 목록화면의 셀과 보기 화면의 셀이 Seque로 연결되어 있죠,이떄는 이셀이 Segue를 생성한 sender가 됩니다.이 Sender는 방금추가한 메소드의 두번쨰 파라미터로 추가됩니다 이 sender를 사용해서 몇번째 셀을 선택했는지 계산해야 됩니다 sender의 형식을 보면 sender: Any?로 선언되어 있죠 이걸 실제 자료형인 UITableViewCell로 바꾸고 셀을 테이블뷰로 전달해서 몇번쨰 위치에 있는 셀인지 확인합니다.
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.memo = DataManager.shared.memoList[indexPath.row]
            }
            
            //이렇게 하면 인덱스 패스 상수를 통해서 몇번째 셀인지 확인할수 있습니다. 다시 prepera for Segue 메소드를 보면 첫번째 파라미터로 현재 실행중인 segue가 전달됩니다 여기에서 목록화면과 보기화면을 전달할수 있습니다.segue를 실행하는 화면을 .sourse 라고 합니다 그리고 새롭게 표시되는 화면을 .destination이라고 합니다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //이 메소드는 뷰 컨트롤러가 생성된후에 자동으로 호출됩니다. 주로 한번만 실행되는 초기화 코드를 여기서 구현합니다. 우리가 처리해야되는 이벤트는 뷰가 화면에 표시되는 이벤트입니다.

        
    
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }//Notification에 대해 공부해볼것 Notification에서 가장 중요한 작업은 Observer를 해제하는 것 입니다. 앱은 정상적으로 사용되지만 내부에서는 메모리가 낭비당하고 있습니다. 수정해보겠습니다.
        
        // Notification이 전달되면 테이블뷰를 업데이트 해야됩니다.다시말해서 UI를 업데이트 해야하는거죠 UI업데이트 코드는 반드시 메인 스레드에서 실행해야 합니다. 이것은 모든 프로그래밍 중에서 기본중의 기본입니다.Ios에서는 스레드를 직접 처리하지 않고 dispachQ나 OperationQueue를 이용해 처리합니다
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //테이블 뷰의 지정된 섹션 행의 수에 뷰를 표시하도록 대리인에게 요청합니다.

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.shared.memoList.count
        //DommyData 숫자 리턴,여기에서 이렇게 저장되어있는 셀을 리턴하면 같은 수의 셀이 테이블 뷰에 표시됩니다
    }

    //테이블보기의 특정 위치에 삽입 할 셀을 데이터 소스에 요청합니다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀 아이덴티 파이어 설정
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // 셀의 환경을 설정(메모와 날짜 설정)
        let target = DataManager.shared.memoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(for:target.insertDate)

        return cell
    }
    

    //스와이프 delete 구현중
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        // 이메소드에서 트루를 리턴하면 편집기능이 활성화 됩니다. 편집을 활성화 한후에는 편집 스타일을 지정해야합니다.
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //메모를 삭제하는 코드 추가
            let target = DataManager.shared.memoList[indexPath.row]// indexPath를 이용해 삭제할 메모를 상수에 저장 하겠습니다.
            DataManager.shared.deleteMemo(target)//데이터베이스에서 삭제
            DataManager.shared.memoList.remove(at: indexPath.row)//배열에서 삭제
            //테이블 뷰에서 삭제 기능을 구현해야 한다면 조금전에 만든 3가지 코드를 전부 구현해야 합니다.
            // Delete the row from the data sourc 테이블 뷰에서 셀을 삭제하는 코드
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //에디트 스타일을 처리하는 코드
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     In a storyboard-based application you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //Get the new view controller          c,,  x,
     */

}
