//
//  FeedViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/19.
//

import UIKit

class FeedViewController: UIViewController {

    private let composeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)),
                        for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(composeButton)
        composeButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        composeButton.frame = CGRect(x: view.frame.width-60-16,
                                     y: view.frame.height-60-16-view.safeAreaInsets.bottom,
                                     width: 60, height: 60)
    }
    
    @objc func didTapCreate() {
        let vc = CreaateNewPostViewController()
        vc.title = "게시물 작성"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }


}
