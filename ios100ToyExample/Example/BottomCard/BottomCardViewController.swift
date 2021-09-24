//
//  BottomCardViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/24.
//

import UIKit
import BLTNBoard

class BottomCardViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("카드 띄우기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var boardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Push Notifications")
        item.image = UIImage(named: "home")
        item.actionButtonTitle = "확인"
        item.alternativeButtonTitle = "스킵 하시겠습니까?"
        item.descriptionText = "적을말이 그닥 없군요..적을말이 그닥 없군요..적을말이 그닥 없군요.."
        item.actionHandler = { _ in
            self.didTapBoardSkip()
        }
        item.alternativeHandler = { _ in
            self.didTapBoard()
        }
        item.appearance.actionButtonColor = .systemIndigo
        item.appearance.alternativeButtonTitleColor = .gray
       return BLTNItemManager(rootItem: item)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
    }

    @objc private func didTapButton() {
        boardManager.showBulletin(above: self)
    }
    
    private func didTapBoard() {
        print("1클릭 되었습니다.")
    }
    
    private func didTapBoardSkip() {
        print("2클릭 되었습니다")
    }
    

}
