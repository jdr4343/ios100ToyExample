//
//  HomeHeaderViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/12.
//

import UIKit
import AVFoundation

class HomeHeaderViewController: UIView {

    static let identifier = "HomeHeaderViewController"

    private var timer = Timer()
    private var count = 0
    private var timecounting = false
    private var buttonimage = false
    private var isplay = false
    
    ///헤더의 백그라운드 이미지 입니다.
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "배경1")
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
    private let min10Button: UIButton = {
        let button = UIButton()
        button.setTitle("10분", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTap10MinLabel), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    private let min20Button: UIButton = {
        let button = UIButton()
        button.setTitle("20분", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTap20MinLabel), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    private let min30Button: UIButton = {
        let button = UIButton()
        button.setTitle("30분", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTap30MinLabel), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    private let hour1Button: UIButton = {
        let button = UIButton()
        button.setTitle("1시간", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTap1HourLabel), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    private let add10MinButton: UIButton = {
        let button = UIButton()
        button.setTitle("+10분", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapAdd10MinLabel), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    
    //백색소음 //다양한 소리를 섞을수 있게 하기 위해 여러번 선언하겠습니다.
    var fire: AVAudioPlayer?
    var wind: AVAudioPlayer?
    var rain: AVAudioPlayer?
    var forest: AVAudioPlayer?
    var pencil: AVAudioPlayer?
    var keyboard: AVAudioPlayer?
    var wave: AVAudioPlayer?
     
    
    private let fireButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlayfire), for: .touchUpInside)
        return button
    }()
    
    private let windButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "wind"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlaywind), for: .touchUpInside)
        return button
    }()
    
    private let rainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cloud.rain.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlayrain), for: .touchUpInside)
        return button
    }()
    
    private let forestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "leaf.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlayforeset), for: .touchUpInside)
        return button
    }()
    
    private let pencilButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlaypencil), for: .touchUpInside)
        return button
    }()
    
    private let keybordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "keyboard"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlaykeybord), for: .touchUpInside)
        return button
    }()
    
    private let waveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "파도"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapPlaywave), for: .touchUpInside)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return button
    }()
    
    //구현대기 / 음악파일 배열을 만들어서 재생하기
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
        min30Button.frame = CGRect(x: width/2-25,
                                      y: safeAreaInsets.bottom+20,
                                      width: 50, height: 50)
        
        min20Button.frame = CGRect(x: min30Button.left-75,
                                      y: safeAreaInsets.bottom+20,
                                      width: 50, height: 50)
        min10Button.frame = CGRect(x: min20Button.left-75,
                                   y: safeAreaInsets.bottom+20,
                                   width: 50, height: 50)

        hour1Button.frame = CGRect(x: min30Button.right+25,
                                    y: safeAreaInsets.bottom+20,
                                    width: 50, height: 50)
        add10MinButton.frame = CGRect(x: hour1Button.right+25,
                                       y: safeAreaInsets.bottom+20,
                                       width: 50, height: 50)
        
        timeLabel.frame = CGRect(x: 0, y: min30Button.bottom+80, width: width, height: 50)
        
        
        
        //버튼
        startStopButton.frame = CGRect(x: width/2-30,
                                       y: min30Button.bottom+130,
                                       width: 60, height: 60)
        backwordButton.frame = CGRect(x: startStopButton.left - 75
                                      , y: min30Button.bottom+130,
                                      width: 60, height: 60)
        forwardButton.frame = CGRect(x: startStopButton.right+25,
                                     y: min30Button.bottom+130,
                                     width: 60, height: 60)
        resetLabel.frame = CGRect(x: width/2-30, y: min30Button.bottom+180, width: 60, height: 50)
        
        
        //음악 버튼
        fireButton.frame = CGRect(x: width/2-25,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        rainButton.frame = CGRect(x: fireButton.right+10,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        windButton.frame = CGRect(x: rainButton.right+10,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        forestButton.frame = CGRect(x: windButton.right+10,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        pencilButton.frame = CGRect(x: fireButton.left-60,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        keybordButton.frame = CGRect(x: pencilButton.left-60,
                                  y: min30Button.bottom+30,
                                  width: 50, height: 50)
        
        
        waveButton.frame = CGRect(x: keybordButton.left-50,
                                  y: min30Button.bottom+40,
                                  width: 30, height: 30)
        
    }

     func addSubview() {
        addSubview(headerImageView)
        addSubview(min10Button)
        addSubview(min20Button)
        addSubview(min30Button)
        addSubview(hour1Button)
        addSubview(add10MinButton)
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
    
    //MARK: -타이머
    
    //시간 추가 액션
    @objc private func didTap10MinLabel() {
        count = 600
        timeLabel.text = makeTimeString(hours: 00, minute: 10, seconds: 00)
    }
    @objc private func didTap20MinLabel() {
        count = 1200
        timeLabel.text = makeTimeString(hours: 00, minute: 20, seconds: 00)
    }
    @objc private func didTap30MinLabel() {
        count = 1800
        timeLabel.text = makeTimeString(hours: 00, minute: 30, seconds: 00)
    }
    @objc private func didTap1HourLabel() {
        count = 3600
        timeLabel.text = makeTimeString(hours: 01, minute: 00, seconds: 00)
    }
    @objc private func didTapAdd10MinLabel() {
        
        if timeLabel.text == makeTimeString(hours: 00, minute: 00, seconds: 00) {
            

        } else {
            count += 600
        }
    }
    
    
    //버튼 액션
    @objc private func didTapStartStopButton() {
        
        
        if (timecounting) {
            buttonimage = false
            timecounting = false
            timer.invalidate()
            startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            didTapPause()
        } else {
            didTapPlay()
            if timeLabel.text != makeTimeString(hours: 00, minute: 00, seconds: 00) {
                timecounting = true
                buttonimage = true
                startStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                //didTapPlay()
                timer = Timer.scheduledTimer(
                    timeInterval: 1,
                    target: self,
                    selector: #selector(timerCounter),
                    userInfo: nil,
                    repeats: true)
            }
            
        }
    }
    
    @objc private func didTapResetButton() {
        didTapStop()
        count = 0
        timer.invalidate()
        timeLabel.text = makeTimeString(hours: 00, minute: 00, seconds: 00)
        startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
        
    
    
    @objc private func timerCounter() -> Void {
        count -= 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minute: time.1, seconds: time.2)
        timeLabel.text = timeString
        if count == 1 {
            Alarm()
        }
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
    
    //MARK: - 음악재생
    
    @objc func didTapPlayfire() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "불", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            fire = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            fire?.volume = 0.6
            guard let player = fire else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlaywind() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "바람소리", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            wind = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            wind?.volume = 1.4
            guard let player = wind else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlayrain() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "비", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            rain = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            rain?.volume = 0.5
            guard let player = rain else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlayforeset() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "숲", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            forest = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = forest else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlaypencil() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "연필", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            pencil = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            pencil?.volume = 3.3
            guard let player = pencil else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlaykeybord() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "키보드", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            keyboard = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            keyboard?.volume = 0.9
            guard let player = keyboard else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    @objc func didTapPlaywave() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "파도소리", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            wave = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            wave?.volume = 0.6
            guard let player = wave else {
                return
            }
            
            player.play()
            
        }
        catch {
            print("오류")
        }
    }
    private func Alarm() {
        didTapStop()
        let audioSession = AVAudioSession.sharedInstance()
        let urlString = Bundle.main.path(forResource: "삐삐삐삐알람소리", ofType: "mp3")
        do {
           try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            guard let urlString = urlString else {
                return
            }
            fire = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = fire else {
                return
            }
            player.play()
        }
        catch {
            print("알람오류")
        }
    }
    
    ///재생 초기화 함수입니다.
    func didTapStop() {
        isplay = false
        if let player = fire {
            player.stop()
            fire = nil
        }
        if let player = wind {
            player.stop()
            wind = nil
        }
        if let player = rain {
            player.stop()
            rain = nil
        }
        if let player = forest {
            player.stop()
            forest = nil
        }
        if let player = pencil {
            player.stop()
            pencil = nil
        }
        if let player = keyboard {
            player.stop()
            keyboard = nil
        }
        if let player = wave {
            player.stop()
            wave = nil
        }
    }
    ///재생 중지 함수 입니다.
    func didTapPause() {
        isplay = true
        if let player = fire, player.isPlaying {
            player.pause()
        }
        if let player = wind, player.isPlaying {
            player.pause()
        }
        if let player = rain, player.isPlaying {
            player.pause()
        }
        if let player = forest, player.isPlaying {
            player.pause()
        }
        if let player = pencil, player.isPlaying {
            player.pause()
        }
        if let player = keyboard, player.isPlaying {
            player.pause()
        }
        if let player = wave, player.isPlaying {

            player.pause()
        }
    }
    ///재생 함수입니다.
    func didTapPlay() {
        if let player = fire, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = wind, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = rain, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = forest, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = pencil, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = keyboard, player.prepareToPlay(), isplay == true {
            player.play()
        }
        if let player = wave, player.prepareToPlay(), isplay == true {
            player.play()
        }
    }
    
}
