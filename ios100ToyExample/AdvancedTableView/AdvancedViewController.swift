//
//  AdvancedViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit
import AVFoundation

class AdvancedViewController: UIViewController {

    //테이블 뷰 생성
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        //셀 등록
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(AdvancedCollectionTableViewCell.self, forCellReuseIdentifier: AdvancedCollectionTableViewCell.identifier)
        return table
    }()
    
    //모델 호출
    private var models = [CellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModels()
        
        view.addSubview(table)
        table.tableHeaderView = createTableHeader()
        table.delegate = self
        table.dataSource = self
        
    }
    
    //헤더에 비디오 추가 /avFoundation을 통해 경로를 파일의 경로를 얻겠습니다.
    private func createTableHeader() -> UIView? {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            print("fatalError")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 0
        let headerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: view.frame.size.width, height: view.frame.size.width))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = headerView.bounds
        headerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        return headerView
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    //모델 파일에서 설정해준 모델을 선택하고 설정
    private func setUpModels() {
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Food 1", imageName: "food1"),
                                               CollectionTableCellModel(title: "Food 2", imageName: "food2"),
                                               CollectionTableCellModel(title: "Food 3", imageName: "food3"),
                                               CollectionTableCellModel(title: "Food 4", imageName: "food4"),
                                               CollectionTableCellModel(title: "Food 5", imageName: "food5"),
                                               CollectionTableCellModel(title: "Food 6", imageName: "food6"),
                                               CollectionTableCellModel(title: "Food 7", imageName: "food7")],rows: 2))
        models.append(.list(models: [ListCellModel(title: "First thing"),
                                     ListCellModel(title: "Second thing"),
                                     ListCellModel(title: "Another thing"),
                                     ListCellModel(title: "Other thing"),
                                     ListCellModel(title: "More thing"),
                                     ]))
    }
    
    


}
extension AdvancedViewController: UITableViewDelegate, UITableViewDataSource {
    //모델 배열의 행 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(let models):
            return models.count
        case .collectionView(_, _):
            return 1
        }
    }
    //셀 위치
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
            
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvancedCollectionTableViewCell.identifier,
                                                     for: indexPath) as! AdvancedCollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }
        
        
       
     
    }
    //셀 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
    //셀높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_):
            return 50
        case .collectionView(_, let rows):
            return 185 * CGFloat(rows)
        }
    }
    
}
//각 셀에 delegate를 연결하고 하나를 탭할때 delegate를 통해 릴링하기 때문에 적절한 항목이 인쇄됩니다.
extension AdvancedViewController: AdvancedCollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("Selected \(model.title) ")
    }
    
    
}
