//
//  HomeHeaderViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/12.
//

import UIKit

class HomeHeaderViewController: UIView {

    static let identifier = "HomeHeaderViewController"

    private var timer = Timer()
    private var count = 0
    private var timecounting = false
    
    private var buttonimage = false
    
    ///헤더의 백그라운드 이미지 입니다.
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "파도웨이브1")
        imageView.layer.cornerRadius = 90
        return imageView
    }()
    ///시간 라벨 입니다.
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    ///시간 추가 라벨 입니다
    private let tenMinLabel: UILabel = {
        let label = UILabel()
        label.text = "10분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    private let twentyMinLabel: UILabel = {
        let label = UILabel()
        label.text = "20분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
      //  label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    private let thirtyMinLabel: UILabel = {
        let label = UILabel()
        label.text = "30분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    private let onehourLabel: UILabel = {
        let label = UILabel()
        label.text = "1시간"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    private let addFiveMinLabel: UILabel = {
        let label = UILabel()
        label.text = "+5분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        //label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    
    //백색소음
    
    private let fireButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let windButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "wind"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let rainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cloud.rain.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let forestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "leaf.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let pencilButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let keybordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "keyboard"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let waveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "파도"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    //음악 플레이어
    
    ///타이머를 시작하고 멈추고 음악을 재생하거나 멈춥니다.
    private let startStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    //초기화 버튼 입니다
    private let resetLabel: UIButton = {
        let button = UIButton()
        button.setTitle("reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        
        return button
    }()
    
    
    private let backwordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //헤더 백그라운드 이미지
        headerImageView.frame = bounds
        
        //라벨
        thirtyMinLabel.frame = CGRect(x: width/2-25,
                                      y: safeAreaInsets.bottom+20,
                                      width: 50, height: 50)
        
        twentyMinLabel.frame = CGRect(x: thirtyMinLabel.left-75,
                                      y: safeAreaInsets.bottom+20,
                                      width: 50, height: 50)
        tenMinLabel.frame = CGRect(x: twentyMinLabel.left-75,
                                   y: safeAreaInsets.bottom+20,
                                   width: 50, height: 50)

        onehourLabel.frame = CGRect(x: thirtyMinLabel.right+25,
                                    y: safeAreaInsets.bottom+20,
                                    width: 50, height: 50)
        addFiveMinLabel.frame = CGRect(x: onehourLabel.right+25,
                                       y: safeAreaInsets.bottom+20,
                                       width: 50, height: 50)
        
        timeLabel.frame = CGRect(x: 0, y: thirtyMinLabel.bottom+80, width: width, height: 50)
        
        
        
        //버튼
        startStopButton.frame = CGRect(x: width/2-25,
                                       y: thirtyMinLabel.bottom+130,
                                       width: 50, height: 50)
        backwordButton.frame = CGRect(x: startStopButton.left - 75
                                      , y: thirtyMinLabel.bottom+130,
                                      width: 50, height: 50)
        forwardButton.frame = CGRect(x: startStopButton.right+25,
                                     y: thirtyMinLabel.bottom+130,
                                     width: 50, height: 50)
        resetLabel.frame = CGRect(x: width/2-30, y: thirtyMinLabel.bottom+180, width: 60, height: 50)
        
        
        //음악 버튼
        fireButton.frame = CGRect(x: width/2-25,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        rainButton.frame = CGRect(x: fireButton.right+10,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        windButton.frame = CGRect(x: rainButton.right+10,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        forestButton.frame = CGRect(x: windButton.right+10,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        pencilButton.frame = CGRect(x: fireButton.left-60,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        keybordButton.frame = CGRect(x: pencilButton.left-60,
                                  y: thirtyMinLabel.bottom+30,
                                  width: 50, height: 50)
        
        
        waveButton.frame = CGRect(x: keybordButton.left-50,
                                  y: thirtyMinLabel.bottom+40,
                                  width: 30, height: 30)
        
    }

     func addSubview() {
        addSubview(headerImageView)
        addSubview(tenMinLabel)
        addSubview(twentyMinLabel)
        addSubview(thirtyMinLabel)
        addSubview(onehourLabel)
        addSubview(addFiveMinLabel)
        addSubview(startStopButton)
        addSubview(backwordButton)
        addSubview(forwardButton)
        addSubview(timeLabel)
        addSubview(resetLabel)
        //음악 버튼
        addSubview(fireButton)
        addSubview(windButton)
        addSubview(rainButton)
        addSubview(forestButton)
        addSubview(pencilButton)
        addSubview(keybordButton)
        addSubview(waveButton)
    }
    
    //라벨 액션
    
    
    
    
    //버튼 액션
    @objc private func didTapStartStopButton() {
        if (timecounting) {
            buttonimage = false
            timecounting = false
            timer.invalidate()
            startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
          
            } else {
                timecounting = true
                buttonimage = true
                startStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                timer = Timer.scheduledTimer(
                    timeInterval: 1,
                    target: self,
                    selector: #selector(timerCounter),
                    userInfo: nil,
                    repeats: true)
          
          }
    }
    
    @objc private func didTapResetButton() {
        count = 0
        timer.invalidate()
        timeLabel.text = makeTimeString(hours: 0, minute: 0, seconds: 0)
        startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
        
       @objc private func timerCounter() -> Void {
        count -= 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minute: time.1, seconds: time.2)
        timeLabel.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600),
                ((seconds % 3600) / 60),
                ((seconds % 3600) % 60))
    }
    
   private func makeTimeString(hours: Int, minute: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minute)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
}
