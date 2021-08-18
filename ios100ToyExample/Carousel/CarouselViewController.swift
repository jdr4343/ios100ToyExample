//
//  CarouselCallectionViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class CarouselViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CollectionTableViewCellDelegate {
    
    //테이블 뷰 생성
    let tableView: UITableView = {
       let table = UITableView()
        
        //CarouselTableViewCell에서 만들었던 cell을 등록하여 줍니다.
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    //테이블 뷰의 셀을 구동할 뷰 모델의 배열
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels:
        [TileCollectionViewCellViewModel(name: "애플",
                                         backgroundColor: .systemFill),
         TileCollectionViewCellViewModel(name: "삼성",
                                          backgroundColor: .systemBlue),
         TileCollectionViewCellViewModel(name: "아마존",
                                          backgroundColor: .systemGreen),
         TileCollectionViewCellViewModel(name: "구글",
                                          backgroundColor: .systemOrange),
         TileCollectionViewCellViewModel(name: "유튜브",
                                          backgroundColor: .red),
         TileCollectionViewCellViewModel(name: "트위치",
                                          backgroundColor: .systemIndigo)])
    ]
    
    //저는 여기에서 데이타 소스를 두번넣어서 2시간 동안 삽질 했습니다.. 그리고 Xcode를 너무 믿지 마십시오.. ㅜㅜ 콘솔로그는 날 배신 했습니다. 휴먼에러는 너무 무서운것..에러의 머부분은 대소문자 입니다.저 같은 초보자들은 자주자주 시뮬레이터를 돌려주세요.. 저처럼 다 짠 다음 돌리다가는 찾기 너무 힘듭니다. 화이팅!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    //여기서는 확장자를 선언하지 않고 class에 바로 연결 하였습니다.저는 약간 식별하기 어렵다고 느껴져서 언제나 확장자를 사용해 연결 해주는 편입니다. 필수 적인 요소가 아니므로 취향것 선택하시면 되겠습니다.
    // MARK: - 테이블뷰 델리겟,데이타
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewmodel = viewModels[indexPath.row]
        //만든 식별자를 추가하여 주고 다운 캐스팅 해줍니다. 다운 캐스팅 같은경우 하위 클래스의 인스턴스를 참조하기 위해 사용합니다.
        //값 형식과 참조 형식은 매우 중요한 요소이니 자주자주 읽어주면서 외워주면 도움이 될꺼 같습니다.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier,
                                                 for: indexPath) as? CollectionTableViewCell else {
                                                    fatalError()
                                                 }
        cell.delegate = self
        cell.configure(with: viewmodel)
        
        return cell
    }
    //셀 크기 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width/2
    }
    
    //MARK: - 콜렉션
    //콜렉션 선택시 기능 구현
    func collectionTableViewCellDidTabItem(with viewModel: TileCollectionViewCellViewModel) {
        let alert = UIAlertController(
            title: viewModel.name,
            message: "성공적으로 아이템을 선택 했습니다. 축하드려요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}


