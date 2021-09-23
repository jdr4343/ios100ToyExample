//
//  DatePickerViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/23.
//

import UIKit

class DatePickerViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        
        button.setTitle("비어있습니다.", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.addSubview(textField)
        view.backgroundColor = .systemBackground
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let filedButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDone))
        toolbar.setItems([doneButton, filedButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datepicker: )), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        textField.textAlignment = .center
        textField.inputView = datePicker
        textField.text = formatDate(date: Date())
        
    }
    @objc private func dateChange(datepicker: UIDatePicker) {
       
        textField.text = formatDate(date: datepicker.date)
    }
    @objc private func didTapDone() {
        button.setTitle(textField.text, for: .normal)
    }
    ///날짜를 사용자에게 표시할수 있도록 문자열로 바꾸는 함수
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    override func viewDidLayoutSubviews() {
        button.frame = CGRect(x: 20, y: 100, width: view.width-40, height: 50)
        textField.frame = CGRect(x: 20, y: button.bottom+30, width: view.width-40, height: 50)
    }

}
