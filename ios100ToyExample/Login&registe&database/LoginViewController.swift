//
//  LoginViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/24.
//
import SkyFloatingLabelTextField
import TransitionButton
import SafariServices
import UIKit
/*
ios 100 ToyExample의 로그인 화면을 구축 할것입니다. 솔직히 로그인이 1도 필요없긴하지만 여러분들이 나중에 로그인을 구현해 볼수도 있으니 저도 배우는 김에 만들었습니다! 🙉
만들기에 앞서 우리는 데이터베이스를 연결할것이기 떄문에 firebase에서 앱등록을 해야합니다! firebase의 홈페이지에 가셔서 앱등록을 하시고
앱에 firebase를(GoogleService-Info)를 추가하여 주세요! 그다음 설면서를 따라 AppDelegate에 FirebaseApp.configure() 를 추가 해주세요. 그러면 준비가 완료됩니다!
(저같은 경우 homeview라고 생각되는 ExampleListView에 NotAuthenticated 라는 함수를 추가 해놨습니다!그렇게 하면 로그인을 하지 않을시 로그인 뷰가 뜨고 로그인이 되었다면 화면이 뜹니다!)
*/

//일단 이화면에서 로그인 화면의 UI를 구성 할것입니다!

class LoginViewController: UIViewController {

    //MARK: - 요소 추가
    
    //이메일, 아이디 텍스트 필드 /'SkyFloatingLabelTextField'라는 프레임 워크를 이용해서 만들 것 입니다.
    private let usernamaEmailField: SkyFloatingLabelTextField = {
      let field = SkyFloatingLabelTextField()
        field.placeholder = "이메일"
        field.title = "이메일을 작성하여 주세요."
        field.returnKeyType = .next
        field.leftViewMode = .always
        //자동으로 대문자가 되지 않게 설정합니다. / 자동완성기능으로 인해 글자가 수정되는 일이 없도록 하겠습니다.
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
        field.title = "비밀번호를 작성하여 주세요."
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
    
    //로그인 버튼 / 회원가입 버튼 / 서비스약관 버튼 /개인정보 정책 버튼을 만들겠습니다. 서비스 약관과 개인정보 정책은 추가할 이유가 없어 그냥 저의 url에 연결해놓겠습니다!만들어도 그만 안만들어도 그만 인 느낌인데 없으니깐 너무 횡해서요..
    
    private let loginButton: TransitionButton = {
        let button = TransitionButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.masksToBounds = true
        button.cornerRadius = 12.0
        button.spinnerColor = .white
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정이 없으신가요?회원가입", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스약관", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보처리방침", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    //헤더 뷰를 생성 하겠습니다.
    private let headerView: UIView = {
        let header = UIView()
        //서브 뷰의 테두리 기준으로 잘리게 설정하겠습니다. clipsToBounds나 masksToBounds 를 설정하지 않으면 cornerRadius로 둥글게 만들었을때 잘라내어도 텍스트가 보일수 있습니다.
        header.clipsToBounds = true
        let backgroundImage = UIImageView(image: UIImage(named: "헤더"))
        header.addSubview(backgroundImage)
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubView()
        usernamaEmailField.delegate = self
        passwordField.delegate = self
        
        //버튼 타겟 설정
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabcreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabtermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //프레임을 설정합니다.
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        usernamaEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52
        )
        passwordField.frame = CGRect(
            x: 25,
            y: usernamaEmailField.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 15,
            width: view.width - 50,
            height: 52
        )
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 5,
            width: view.width - 50,
            height: 52
        )
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width-20,
            height: 50
        )
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width-20,
            height: 50
        )
        configureHeaderView()
        
    }
    
    private func addSubView() {
        view.addSubview(headerView)
        view.addSubview(usernamaEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    //헤더 뷰 구성 추가
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        //헤더뷰의 첫번째 서브뷰(이미지뷰)가 헤더뷰를 꽉 채우도록 경계를 정해줍니다.
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
    }
    
    
    //버튼 구현
    
    @objc func didTabLoginButton() {
        loginButton.startAnimation()
        DispatchQueue.main.async {
            self.loginButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0.5) {
                let vc = ExampleListViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc func didTabcreateAccountButton() {
        let vc = ResisterationViewController()
        vc.title = "계정 생성"
        present(UINavigationController(rootViewController: vc),animated: true)
    }
    
    @objc func didTabtermsButton() {
        guard let url = URL(string: "https://www.notion.so/9efbaec014d84700a6e17733ad829447?v=cb2389fba533469086f9798c5b23a75f") else {
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    @objc func didTabPrivacyButton() {
        guard let url = URL(string: "https://github.com/jdr4343") else {
        return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
// 텍스트 필드 델리게이트 연결
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernamaEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTabLoginButton()
        }
        return true
    }
}
