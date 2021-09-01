//
//  ResisterationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton
import JGProgressHUD

class RegistrationViewController: UIViewController {

    //로그인시에 스피너를 보여주기위해 추가 하겠습니다.
    private let spinner = JGProgressHUD(style: .dark)
    
    private let usernameField: SkyFloatingLabelTextField = {
      let field = SkyFloatingLabelTextField()
        field.placeholder = "이름"
        field.title = "이름을 작성해 주세요."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .darkGray
        field.selectedTitleColor = .systemPink
        field.selectedLineColor = .darkGray
        field.textColor = .darkGray
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0
        return field
    }()
    
    private let emailField: SkyFloatingLabelTextField = {
      let field = SkyFloatingLabelTextField()
        field.placeholder = "이메일"
        field.title = "이메일을 작성해 주세요."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .darkGray
        field.selectedTitleColor = .systemPink
        field.selectedLineColor = .darkGray
        field.textColor = .darkGray
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0
        return field
    }()
    
    private let passwordField: SkyFloatingLabelTextField = {
      let field = SkyFloatingLabelTextField()
        field.placeholder = "비밀번호"
        field.title = "비밀번호는 8자리 이상으로 작성 해주세요."
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .darkGray
        field.selectedTitleColor = .systemPink
        field.selectedLineColor = .darkGray
        field.textColor = .darkGray
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0
        return field
    }()
    
    
    public let registerButton: TransitionButton = {
        let button = TransitionButton()
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.masksToBounds = true
        button.cornerRadius = 12.0
        button.spinnerColor = .white
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(didTabRegisterButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+20, width: view.width-40, height: 52)
    }

    //회원 가입 버튼 기능 구현 / 사용자가 모든 데이터를 이상없이 전달했을경우 AuthManager를 통해서 계정을 생성하겠습니다.
    @objc func didTabRegisterButton() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        registerButton.startAnimation()
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            
            alertUserRegisterError()
            return
        }
      
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registerd in
            DispatchQueue.main.async {
                
               
                if registerd {
                  
                // 성공
                } else {
                    //실패
                    self.alertUserRegisterError()
                }
                
                
            }
        }
        self.registerButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5) {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func alertUserRegisterError(message: String = "새 계정을 만들려면 모든 정보를 입력하십시오.비밀번호가 8자리 이상인지 확인해주게요.") {
        let alert = UIAlertController(title: "회원가입 실패",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
        registerButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
        
    }



}
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTabRegisterButton()
        }
        return true
    }
}
