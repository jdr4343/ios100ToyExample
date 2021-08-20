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
    //오디오 준비
    var keyboard: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.center = view.center

    }
  
    //오디오 재생
    @objc func didTabPlay() {
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
            
            guard let player = keyboard else {
                return
            }
            //Stop으로 바꾸면 멈춥니다. 스탑버튼을 만들고 타겟을 연결하고 player.stop을 하면 재생이 멈추겠죠!?
            player.play()
        }
        catch {
            print("오류")
        }
    }

}
