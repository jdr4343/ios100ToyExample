//
//  EventKitViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/10/18.
//

import UIKit
import EventKit
import EventKitUI

class EventKitViewController: UIViewController, EKEventViewDelegate {
  
    let store = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이벤트 킷"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
   
    @objc private func didTapAdd() {
        ///사용자에게 권한을 요청하고 권한이 허용된다면 이벤트 페이지를 오픈 합니다.
        store.requestAccess(to: .reminder) { [weak self] success, error in
            if success,error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.store else { return }
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = "유튜브 비디오"
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                    
                    let otherVC = EKEventEditViewController()
                    otherVC.eventStore = store
                    otherVC.event = newEvent
                    
                
                    
                    self?.present(otherVC, animated: true, completion: nil)
                    
//
//                    let vc = EKEventViewController()
//                    vc.delegate = self
//                    vc.event = newEvent
//                    let navVC = UINavigationController(rootViewController: vc)
//                    self?.present(navVC, animated: true, completion: nil)
                }
            }
        }
        
      
    }

    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        
    }
}
