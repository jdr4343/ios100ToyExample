//
//  LoginViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit
import SafariServices
import SkyFloatingLabelTextField
import TransitionButton
import FBSDKLoginKit
import FirebaseAuth
import JGProgressHUD

/*
 ios 100 ToyExample의 로그인 화면을 구축 할것입니다. 솔직히 로그인이 1도 필요없긴하지만 여러분들이 나중에 로그인을 구현해 볼수도 있으니 저도 배우는 김에 만들었습니다! 🙉
 만들기에 앞서 우리는 데이터베이스를 연결할것이기 떄문에 firebase에서 앱등록을 해야합니다! firebase의 홈페이지에 가셔서 앱등록을 하시고
 앱에 firebase를(GoogleService-Info)를 추가하여 주세요! 그다음 설면서를 따라 AppDelegate에 FirebaseApp.configure() 를 추가 해주세요. 그러면 준비가 완료됩니다!
 (저같은 경우 homeview라고 생각되는 ExampleListView에 NotAuthenticated 라는 함수를 추가 해놨습니다!그렇게 하면 로그인을 하지 않을시 로그인 뷰가 뜨고 로그인이 되었다면 화면이 뜹니다!)
 */

//일단 이화면에서 로그인 화면의 UI를 구성 할것입니다!

class LoginViewController: UIViewController {
    
    //MARK: - 요소 추가
    
    //로그인시에 스피너를 보여주기위해 추가 하겠습니다.
    private let spinner = JGProgressHUD(style: .dark)
    
    //이메일, 아이디 텍스트 필드 /'SkyFloatingLabelTextField'라는 프레임 워크를 이용해서 만들 것 입니다.
    private let usernamaEmailField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "이메일"
        field.title = "이메일을 작성해 주세요."
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
        field.title = "비밀번호를 작성해 주세요."
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
    
    //페이스북 로그인 버튼 /저는 여기서 오래 해맸는데.. 이걸 private로 선언하면 FacebookAuthProvider를 찾지 못합니다..ㅔㅔ.. 파일이 점점 커지다보니 중복 이름을 쓰는 경우가 있을까봐 뭔가 생활화 됬는데 대참사네요.. 검색해도 이런식으로 알려주지는 않아서 ㅜㅜ 3시간 대참사네요 ㅜㅜㅜㅜㅜㅜㅜ
    let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.text("페이스북으로 시작")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        //권한을 설정 합니다. 사용자의 이메일과 공개프로필을 요청 하겠습니다.
        button.permissions = ["email", "public_profile"]
        return button
    }()
    
    
    //MARK: - 화면
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubView()
        usernamaEmailField.delegate = self
        passwordField.delegate = self
        
        facebookLoginButton.delegate = self
        
        //버튼 타겟 설정
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabcreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabtermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)
        //뷰가 로드될경우 애니메이션 종료
        
        
        
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
            height: 40
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
        facebookLoginButton.frame = CGRect(x: 25,
                                           y: createAccountButton.bottom + 5,
                                           width: view.width - 50,
                                           height: 40)
        
        
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
        view.addSubview(facebookLoginButton)
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
    
    
    //MARK: - 버튼
    
    @objc func didTabLoginButton() {
        //탭 될떄 키보드를 닫도록 설정
        passwordField.resignFirstResponder()
        usernamaEmailField.resignFirstResponder()
        
        //텍스트가 비어 있는지 / 패스워드가 8자 이상인지 유효성 검사
        guard let email = usernamaEmailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            let alert = UIAlertController(title: "회원정보가 다릅니다.",
                                          message: "패스워드의 길이가 8자 미만입니다.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        spinner.show(in: view)
        self.loginButton.startAnimation()
        ///여기에서 로그인 기능을 연결 할 것입니다. 연결하기에 앞서  AuthManager,DataManager가 선행으로 작성 되어야 합니다. 또한 firebase의 Authentication에서 이메일을 사용저장 해주시고,
        ///Realtime Database(테스트)가 만들어고 규칙을 수정 해야 합니다.그리고 회원가입을 해야 등록을 하니 Resister 뷰 또한 작성 되어야 하겠죠?
        /*
         - Realtime Database 규칙수정
         {
         "rules": {
         ".read":true,
         ".write":true
         }
         }
         */
        //파이어 베이스 로그인 구현 / 사용자가 버튼을 탭하면 로그인 기능에서 FirebaseAuth.Auth.auth 라고 로그인 하도록 하고 이메일과 패스워드가 맞는지 확인하겠습니다.
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            
            guard let strongSelf = self else {
                return
            }
            //firebase 인증시도에서 스피너를 제거하겠습니다.
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
                
            }
            
            //오류가 발생하지 않았는지 확인하기 위해 가드문을 추가 하겠습니다. 오류가 발생하면 프린트를 출력 할것입니다.
            guard let result = authResult, error == nil else {
                print("Error cureating User")
                strongSelf.loginButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 0, completion: nil)
                
                let alert = UIAlertController(title: "회원정보가 다릅니다.",
                                              message: "이메일 혹은 패스워드를 확인해 주세요.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true)
                return
            }
            
            //사용자가 로그인하고 탐색 컨트롤러를 해제 하므로 해제 하기전에 사용자 이메일 주소를 저장하겠습니다. 사용자 이메일을 저장하는 이유는 저장소 버킷이 이미지에 대해 사용할수 있는 형식을 가지고 있기 때문입니다. 사용자에 대한 이미지를 쿼리하기 위한 이메일 입니다.
            let user = result.user
            UserDefaults.standard.set(email, forKey: "email")  
            print("Logged IN User:\(user)")
            strongSelf.loginButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5) {
                strongSelf.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @objc func didTabcreateAccountButton() {
        let vc = RegistrationViewController()
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

//MARK: - UITextFieldDelegate

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

//MARK: - 페이스북 버튼 델리게이트

extension LoginViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //버튼을 탭하면 로그아웃을 자동으로 표시하도록 버튼이 업데이트 되지만 저의 경우에는 뷰 컨트롤러에 로그인을 표시 하지 않기 때문에
        //필수 메서드라 생성만 하고 비워두겠습니다.
    }
    
    public func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        spinner.show(in: view)
        //토큰을 가져옵니다
        guard let token = result?.token?.tokenString else {
            print("사용자가 페이스북으로 로그인에 실패 했습니다.")
            spinner.dismiss()
            return
        }
        
        //페이스북으로 로그인한 사용자로 부터 사용자의 이메일과 이름을 가져오겠습니다. /사진을 가져옵니다.
        let facebookRequset = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields" : "email, name, picture.type(large)"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        facebookRequset.start(completion: { _, result, error in
            guard let result = result as? [String: Any], error == nil else {
                print("페이스북으로 부터 정보를 요청하지 못했습니다.")
                self.spinner.dismiss()
                return
            }
            
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String,
                  let picture = result["picture"] as? [String: Any],
                  let data = picture["data"] as? [String: Any],
                  let pictureUrl = data["url"] as? String else {
                print("이메일과 이름 혹은 사진의 결과 값을 얻지 못했습니다.")
                self.spinner.dismiss()
                return
            }
            
            //위에서 받은 이메일과 이름 결과값을 데이터베이스에 전달합니다
//            let name = userName
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                if !exists {
                    let appUser = UserModel(username: userName, emailAddress: email)
                    
                    DatabaseManager.shared.insertNewUser(with: appUser, complation: { success in
                        if success {
                            
                            //가져온 사진을 데이터베이스에 저장합니다.⭐️⭐️⭐️
                            guard let url = URL(string: pictureUrl) else {
                                print("url 개체를 생성할수 없습니다.")
                                return
                            }

                            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                                guard let data = data, error == nil else {
                                    print("페이스북으로 부터 데이터를 받아 오는것에 실패 했습니다.")
                                    return
                                }
                                
                                let filename = appUser.profilePictureFileName
                                StorageManager.shared.uploadProfilePicture(with: data, fileName: filename, complation: { result in
                                    switch result {
                                    case .success(let downloadUrl):
                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                        print(downloadUrl)
                                    case .failure(let error):
                                        print("스토리지 오류 \(error)")
                                    }
                                })
                            })
                            //⭐️⭐️⭐️⭐️ URLSession을 재개합니다.
                            .resume()
                        }
                    })
                }
            })
            
            //엑세스 토큰을 사용 하겠습니다
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                guard authResult != nil, error == nil else {
                    //에러가 생긴다면 파이어베이스에서 페이스북 을 Enabled를 했는지 확인 해보세요 😃 앱 아이디와 엡 비밀번호는 페이스북 디벨로퍼의 기본설정에 있습니다.
                    strongSelf.spinner.dismiss()
                    print("사용자가 페이스북 로그인에 실패 했습니다, MFA가 필요할수 있습니다.")
                    return
                }
                //성공
                
                strongSelf.spinner.dismiss()
                strongSelf.dismiss(animated: true, completion: nil)
            })
        })
    }
}
