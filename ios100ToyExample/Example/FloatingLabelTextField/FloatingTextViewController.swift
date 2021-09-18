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
    private let textField: UITextField = {
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
    private let passwordField: UITextField = {
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
    private let newTextField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "이메일"
        field.title = "이메일을 적어주세요."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .darkGray
        field.selectedTitleColor = .darkGray
        field.selectedLineColor = .darkGray
        field.textColor = .darkGray
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0
        
        return field
    }()
   
    
   private let newPasswordField: SkyFloatingLabelTextFieldWithIcon = {
        let field = SkyFloatingLabelTextFieldWithIcon()
        field.placeholder = "비밀번호"
        field.title = "비밀번호를 적어주세요."
        //여기에 리터럴 이미지를 넣으면 색상이 변하게 할수 있지만 리터럴 이미지를 구하지 못했습니다... 있으시다면 한번 넣어서 사용해 보세요!
       // field.iconImage = UIImage(imageLiteralResourceName:  )
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.tintColor = .darkGray
        field.selectedTitleColor = .darkGray
        field.selectedLineColor = .darkGray
        field.textColor = .darkGray
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0

        return field
    }()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        view.addSubview(passwordField)
        view.addSubview(newTextField)
        view.addSubview(newPasswordField)
        textField.delegate = self
        passwordField.delegate = self
        newTextField.delegate = self
        newPasswordField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.frame = CGRect(x: 25, y: 140, width: view.width - 50, height: 52)
        passwordField.frame = CGRect(x: 25, y: textField.bottom+10, width: view.width - 50, height: 52)
        newTextField.frame = CGRect(x: 25, y: passwordField.bottom+10, width: view.width - 50, height: 52)
        newPasswordField.frame = CGRect(x: 25, y: newTextField.bottom+10, width: view.width - 50, height: 52)
    }

    

}
//텍스트 키보드에서 리턴키를 누르면 자동으로 다음 으로 넘어가도록 설정 하겠습니다.
extension FloatingTextViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textField {
            passwordField.becomeFirstResponder()
        }
        if textField == newTextField {
            newPasswordField.becomeFirstResponder()
        }
        return true
    }
}
