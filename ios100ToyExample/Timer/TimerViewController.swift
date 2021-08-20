//
//  TimerViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit
//스토리 보드를 통해 구현하겠습니다.
class TimerViewController: UIViewController {

   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer = Timer()
    var count = 0
    var timerCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitleColor(UIColor.green, for: .normal)
    }
    
    @IBAction func didTabStartButton(_ sender: Any) {
        //타이머가 진행중이라면 Stop을 표시하고 진행중이 아니라면 Start를 표시하겠습니다.기본 값이 false이기 때문에 재생을 하고 있지 않을땐 Start입니다.
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
        } else {
            timerCounting = true
            startButton.setTitle("Stop", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(timerCounter),
                userInfo: nil,
                repeats: true)
        }
    }
    
    
    @IBAction func didTabResetButton(_ sender: Any) {
        self.count = 0
        self.timer.invalidate()
        self.timeLabel.text = self.makeTimeString(hours: 0, minute: 0, seconds: 0)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.green, for: .normal)
        
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        //time에 secondsToHoursMinutesSeconds 값을 할당하고 색인번호를 통해 인트 값을 전달합니다
        let timeString = makeTimeString(hours: time.0, minute: time.1, seconds: time.2)
        timeLabel.text = timeString
    }
   
    
    
    //시간과 레이블 스트링 구현
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minute: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minute)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    //숙제를 하나 드릴까 합니다.(구현하기 귀찮아서는 아니고..헤헷..) 스토리보드를 통해 10분을 추가하는 버튼을 만들어서 연결하고
    //카운트를 - 1로 바꿔서 시간이 증가하는게 아닌 줄어드는 타이머를 만들어 보시길 바랍니다. 이때 스타트를 누르면 스톱으로 바뀌어야 겠죠? 여기에 구현되어 있는 코드 만으로 충분히 구현가능합니다. 제가 적어드린것과 복사 붙여넣기 만 하면 됩니다.
    //아래에는 힌트가 있습니다.
    
    
    
    
    
    
    
    
    
    
    
    
    
    //hint : 카운트는 초단위로 움직인다. 숫자를 증가시키면 600초를 증가시키면 되겠구나!음.. 그러면 숫자는 안변하니깐 텍스트를 바꿔야 겠군.. 시간이 증가하면 안되니깐 +1되는 코드를 -1로 바꿔야겠구나! 그리고 나서  else에 구현되어 있는 코드를 복사 붙여넣기 하면되겠어!
    //아래에는 답이 있습니다.
    
    
    
    
    
    
    
    
//    @objc func timerCounter() -> Void {
//        count = count - 1
    
    
//    @IBAction func plus10MinTapped(_ sender: Any) {
//        self.count = 600
//        self.timer.invalidate()
//        self.TimarLabel.text = self.makeTimeString(hours: 0, minute: 10, seconds: 0)
//
//        if(timerCounting) {
//            timerCounting = true
//            StartStopBtn.setTitle("Stop", for: .normal)
//            StartStopBtn.setTitleColor(UIColor.green, for: .normal)
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
//        }
//
//    }
}



