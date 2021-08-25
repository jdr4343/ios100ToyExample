//
//  CheakViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class CheckViewController: UIViewController {

    //모델을 토대로 배열 생성
    let items: [CheckListItem] = [
    "아침에 일어나자 마자 아침 명상",
        "미지근한 물 한잔",
        "누워 있으면 다시 잠이 오니 밖에 산책",
        "산책하는 김에 커피 한잔",
        "간단한 요깃거리",
        "돌아가는 일을 알기위해 유튜브 시청 ^^헤헷",
        "힐링했으면 책상에 앉아 공부 시작",
        "하루는 짧고 시간은 빠르구나.."
        //맵으로 체크리스트 항목을 압축
    ].compactMap({
        CheckListItem(title: $0)
    })
    
    //테이블 뷰 생성,셀 추가
    // private는 이 상수를 포함하는 클래스나 행당 클래스의 익스텐션에서만 접근이 가능하도록 합니다!
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //주로 viewDidLayoutSubviews 는 프레임을 제공해야 할때 작성합니다
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//테이블뷰에 delegate와 dataSource를 연결하기 위해 추가해주고 기능을 구현해줍니다.. 메인 뷰에서 연결해도 되지만 코드가 지저분 해질겁니다 ㅠㅠ
//아래의 두코드는 필수코드 입니다. 첫번째 코드는 이름그대로 섹션안의 행의수를 결정 짓고 두번째 코드는 특정 위치에 삽입할 Cell에 대해 DataSource에 요청합니다. 그리고 재사용 하기 위해서 dequeueReusableCell추가 했습니다!
extension CheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        //삼항 연산자를 이용해 체크 됬으면 체크마크를 반환하고 아니라면 none을 반환 하겠습니다.
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        //특정 셀을 선택하면 체크마크가 보이도록 모델에서 설정한 ischecked를 true값을 반환 해주겠습니다.그냥 true를 리턴한다면 체크를 풀수 없으므로 값을 반전 합니다.그러면 이제 디폴트값이 false였던 isChecked는 탭할경우 값이 true로 바뀌게 됩니다.그리고 체크 될때마다 뷰에 데이터를 reload 함으로써 체크마크가 표시되게 됩니다.
        item.isChecked = !item.isChecked
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
