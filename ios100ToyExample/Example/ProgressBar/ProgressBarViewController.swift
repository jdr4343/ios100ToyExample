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
        button.addTarget(self, action: #selector(didTapstartButton), for: .touchUpInside)
        return button
    }()
    
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .systemGreen
        progressView.clipsToBounds = true
       
        return progressView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(progressView)
        //progressView 진행률
        progressView.setProgress(0, animated: false)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        progressView.frame = CGRect(x: 10, y: 100, width: view.width-20, height: 200)
        //크기 조절
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)

    }
    
    @objc private func didTapstartButton() {
        for x in 0..<101 {
            DispatchQueue.main.asyncAfter(deadline: .now()+(Double(x)*0.25),execute: {
                self.progressView.setProgress(Float(x)/100, animated: true)
                self.button.setTitle("\(x)%", for: .normal)
            })
        }
    }
}



