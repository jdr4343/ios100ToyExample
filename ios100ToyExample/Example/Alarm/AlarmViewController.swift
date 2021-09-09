//
//  AlarmViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
//StoryBoard ID 를 통해 뷰전환을 했습니다. identifier를 한번씩 확인해 주시고 제대로 연결되었는지 확인 해주셔야 에러를 피할수 있습니다.
//알람 기능을 테스트 할경우 앱을 계속 보고 있을경우 진행 되지 않습니다. 앱을 잠깐 대기 상태로 만들어주시면 잘울립니다.

import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
//테이블뷰 생성
    @IBOutlet var table: UITableView!
    //빈 배열 생성
    var models = [AlarmModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    //액션 연결
    @IBAction func didTapAdd() {
        //뷰전환
                guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddAlarmViewController else {
                    return
                }
                vc.title = "새로운 알람"
                vc.navigationItem.largeTitleDisplayMode = .never
                //완료 핸들러
                vc.completion = { [weak self] title, body, date in
                    guard let strongSelf = self else {
                        return
                    }
                    //추가 컨트롤러
                    DispatchQueue.main.async {
                        strongSelf.navigationController?.popToRootViewController(animated: true)
                        let new = AlarmModel(title: title, date: date, identifier: "id_\(title)")
                        strongSelf.models.append(new)
                        strongSelf.table.reloadData()
                        
                        //알림 콘텐츠 개체를 생성하여 UNMutableNotificationContent를 저장후 속성 부여
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.sound = .default
                        content.body = body
                        
                        //알림에 대한 트리거 추가 / 날짜와 시간으로 추가 / 10초 뒤 알람
                        let targetDate = date
                        //날짜의 구성요소를 추가하고 반복 false 전달
                        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute, .second], from: targetDate),repeats: false)
                        //알림 요청을하고 이를 식별자로 초기화 할것입니다.
                        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
                        //알림을 예약
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                            if error != nil  {
                                print("Error Error Hell Yeah")
                                return
                            }
                        })
                        
                    }
                }
                navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapTest() {
        //권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { succes, error in
            if succes {
                print("Test Start")
                self.AlarmTest()
            } else if error != nil {
                print("Test error")
            }
        })
    }
    //테스트 기능 구현
    func AlarmTest() {
        //알림 콘텐츠 개체를 생성 저장후 속성 부여
        let content = UNMutableNotificationContent()
        content.title = "테스트가 성공적으로 진행 됬습니다."
        content.sound = .default
        content.body = "축하드립니다."
        //알림에 대한 트리거 추가 / 날짜와 시간으로 추가 / 10초뒤 알림
        let targetDate = Date().addingTimeInterval(10)
        //날짜의 구성요소를 추가 하고 반복하지 않도록 false 전달
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                from: targetDate), repeats: false)
        //알림을 요청하고 식별자로 초기화
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        //알림을 예약
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("Alarm Failed")
                return
            }
        })
    }


    
    

}
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    //섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //테이블 뷰의 title 텍스트 지정
        cell.textLabel?.text = models[indexPath.row].title
        //테이블 뷰의 예약된 알람의 날짜 설정
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY at hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }


}
