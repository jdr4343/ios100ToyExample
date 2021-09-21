//
//  SliderViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/22.
//

import UIKit

class ProgressBarViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("시작", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
       // button.addTarget(self, action: #selector(didTapstartButton), for: .touchUpInside)
        return button
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .systemGreen
        //progressView 진행률
        progressView.setProgress(0, animated: false)
        return progressView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(progressView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        progressView.frame = CGRect(x: 10, y: 100, width: view.width-20, height: 20)
      
        
    }
    
//    @objc private func didTapstartButton() {
//        for x in 0...<100 {
//
//        }
//    }

    

}
