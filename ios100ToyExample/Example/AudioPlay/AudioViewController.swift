//
//  AudioViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit
import AVFoundation

//제가 공부 할때 자주 듣는 키보드 소리를 플레이 해보겠습니다.
class AudioViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(didTabPlay), for: .touchUpInside)
       return button
    }()
    let Stopbutton: UIButton = {
        let button = UIButton()
        button.setTitle("재생 중지", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(didTabStop), for: .touchUpInside)
       return button
    }()
    //오디오 준비
    var keyboard: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(Stopbutton)
        button.center = view.center
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Stopbutton.frame = CGRect(x: 50, y: button.bottom+20, width: view.width - 100, height: 50)

    }
  
    //오디오 재생
    @objc func didTabPlay() {
        
        let audioSession = AVAudioSession.sharedInstance()
        //플레이 셋업
        let urlString = Bundle.main.path(forResource: "삐삐삐삐알람소리", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = urlString else {
                return
            }
            keyboard = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = keyboard else {
                return
            }
            
                player.play()
            
        }
        catch {
            print("오류")
        }
    }

    @objc func didTabStop() {
         if let player = keyboard, player.isPlaying {
        player.stop()
            player.play()
        }
    }

}



