//
//  AddAlarmViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class AddAlarmViewController: UIViewController,UITextFieldDelegate {

    //스토리 보드로 부터 아울렛 연결
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var bodyField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //사용자가 추가한 정보를 가져와 다른 컨트롤러에서 사용하기 위해 공용 완료 속성 추가
    public var complation:((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //장치의 엔터를 눌렀을 경우 키보드를 닫기 위해서 델리게이트 연결
        titleField.delegate = self
        bodyField.delegate = self
        //네비게이션 바버튼 코드로 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    //기능 추가
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            //데이트 피커에서 날짜 데이터 가져오기
            let targetDate = datePicker.date
            //데이터 가져오기 이 데이터들은 위에서 공용속성으로 선언했기 때문에 다른 컨트롤러에서도 사용할수 있습니다.
            complation?(titleText, bodyText, targetDate)
        }
    }
    //델리게이트 기능 추가
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

   
}
