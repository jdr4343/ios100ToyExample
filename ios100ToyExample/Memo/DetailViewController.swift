//
//  DetailViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memoTableView: UITableView!
    
    var memo: Memo?
    
    let formatter: DateFormatter = {
    let f = DateFormatter ()
     f.dateStyle = .long
     f.timeStyle = .short
     f.locale = Locale(identifier: "ko_kr")
     return f
 }()
    //이전 화면에서 전달한 메모를 저장할 속성을 추가 하겠습니다. 뷰 컨트롤러가 초기화 되는 시점에는 값이 없기때문에 옵셔널로 저장하겠습니다.
    
    
    //공유 버튼 활성화
    @IBAction func share(_ sender: UIBarButtonItem) {
        //UIActivityViewController로 공유기능 구현
        guard let memo = memo?.content else { return }
        
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        //아이패드 호환 팝오버 뷰 버튼 지정.
        if let pc = vc.popoverPresentationController {
            pc.barButtonItem = sender
        }
        
        present(vc, animated: true, completion: nil)//present 메소드를 이용해서 Activity를 화면에 표시하겠습니다.
    }
    
    
    @IBAction func deleteMemo(_ sender: Any) {//확인 버튼 구현 , 경고창
        let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            //3번째 파라미터는 버튼을 선택했을떄 실행할 코드를 전달합니다.
            //destructive 스타일을 전달하면 텍스트가 빨간색으로 전달됩니다.
            
            
            DataManager.shared.deleteMemo(self?.memo)//현재화면에 표시되어 있는 메모도 파라미터로 전달하겠습니다. 이렇게 하면 현재표시되어 있는 메모가 삭제되는거니깐 화면을 메모를 삭제하고 이전화면으로 돌아가야합니다. 화면을 pop해보겠습니다.
            self?.navigationController?.popViewController(animated: true)
            //Datamanager에서 만든 deleteMemo 코드를 okAction 클로저에서 호출하겠습니다.
        }
        alert.addAction(okAction)//addAction 메소드를 호출해서 확인버튼을 alert에 추가하겠습니다.
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        //경고창을 화면에 표시하겠습니다.
    }
    
    
 //툴바에 있는 버튼을 탭할떄 Segue가 실행됩니다. memo 속성에 저장되어 있는 memo를 그대로 전달하겠습니다. 다만 앞에서 설명했던것처럼 navigationController거쳐서 전달하기 떄문에 최종뷰 Controller에 접근하는 코드가 좀 달라집니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = memo
            //네비게이션 컨트롤러가 관리하는 첫번째 뷰 컨트롤러로 메모가 전달됩니다. 여기에서 네비게이션 컨트롤러가 관리하는 첫번쨰 뷰 컨트롤러는 ComposeViewController 입니다. 다시 ComposeViewController로 가겠습니다.
        }
    }
    var token: NSObjectProtocol?
    //이속성에는 NSObjectProtocol 토큰을 저장하겠습니다.
    //옵저버를 해제하는 코드를 구현하겠습니다.
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //옵저버를 추가하겠습니다. 이렇게 memodidChange에 옵저버를 추가했습니다. 그리고 여기에서 TableView를 reload 하겠습니다.
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memodidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            self?.memoTableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        default:
            fatalError()
        }
    }
    
    
}
