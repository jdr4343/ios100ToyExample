//
//  FloatingTextViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit
import SkyFloatingLabelTextField
//일반적인 텍스트 필드하나와 프레임 워크를 사용한 텍스트 필드를 구현 해보겠습니다.

class FloatingTextViewController: UIViewController {

    //일반 텍스트필드를 2게 추가하고 유용한 요소들을 추가해보겠습니다.
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "일반 텍스트 필드 입니다."
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        //왼쪽에 여백을 주고 언제나 왼쪽에서 부터 읽겠습니다.
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        //자동으로 대문자가 되지 않도록 설정합니다. / 자동완성 기능을 꺼서 자동으로 글자가 수정 되는일이 없도록 하겠습니다.
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        //테두리를 기준으로 잘리도록 masksToBounds를 추가하고 모서리를 깎아주겠습니다.
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        //테두리를 생성하겠습니다.
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 작성한다 가정하겠습니다."
        //아래의 속성을 추가하면 글을 적을때 ***이런식으로 비밀로 만들어집니다!
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    //프레임워크를 사용한 텍스트 필드를 만들겠습니다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
    }
    

    

}
