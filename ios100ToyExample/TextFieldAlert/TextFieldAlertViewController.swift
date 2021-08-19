//
//  TextFieldAlertViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import UIKit

class TextFieldAlertViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .systemTeal
        button.setTitle("경고창 보기", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    private let firstlabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    private let secondlabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(firstlabel)
        view.addSubview(secondlabel)
        button.center = view.center
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstlabel.frame = CGRect(x: view.width/7, y:100, width: 300, height: 50)
        secondlabel.frame = CGRect(x: view.width/7, y: 150, width: 300, height: 50)
    }
    //경고창 추가
    @objc func didTapButton() {
        let alert = UIAlertController(title: "🐥이렇게 사용자들에게 메시지를 알릴수 있습니다.",
                                      message: "alert 형식 뿐만아니라 아래에서 슬라이드해서 올라오는 액션시트도 있습니다.곧 구현할거니 다음에 배워보실수 있을겁니다.",
                                      preferredStyle: .alert)
        //텍스트 필드 추가
        alert.addTextField { field in
            field.placeholder = "이렇게 핸들러를 사용해서 기능구현을 하는데 매우자주 보게됩니다."
            field.returnKeyType = .next //키보드에서 리턴키를 눌렀을때 어떤 방식으로 구현 할지 정합니다. 저는 .next를 선택 하겠습니다
        }
        alert.addTextField { field in
            field.placeholder = "이렇게 리턴 키를 누르면 .next를 골랐으니 다음으로 넘어가게됩니다."
            field.returnKeyType = .continue
        }
        //취소버튼과 저장 버튼 추가
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { [self] _ in
            //핸들러 형식으로 데이터를 전달하여 줍니다.
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            let firstField = fields[0]
            let secondField = fields[1]
            //첫번째 메시지만 값을 전달하겠습니다
            guard let first = firstField.text, !first.isEmpty,
                  let second = secondField.text, !second.isEmpty else {
                firstlabel.text = "텍스트가 없습니다."
                secondlabel.text = "텍스트가 없습니다"
                return
            }
            firstlabel.text = first
            secondlabel.text = second
        }))
        
        //경고창 출력
        present(alert, animated: true )
    }
    
    
}
