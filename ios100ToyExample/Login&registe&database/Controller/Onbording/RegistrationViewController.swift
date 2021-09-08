//
//  ResisterationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton
import FirebaseAuth


class RegistrationViewController: UIViewController {
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
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
        field.textColor = .label
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
        field.textColor = .label
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
        field.textColor = .label
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
        view.addSubview(profileImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(didTabRegisterButton), for: .touchUpInside)
        
        
        //Register의 프로필을 클릭하면 아래의 gesture 코드와 상호작용을 활성화
        profileImageView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        
        //사용자가 프로필 사진을 탭하고 프로필를 변경할수 있도록 addGestureRecognizer을 추가하여 제스처를 추가하겠습니다.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        profileImageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //프로필 포토 사이즈
        let profilePhotoSize  = view.width/3
        profileImageView.frame = CGRect(x: (view.frame.width-profilePhotoSize)/2, y: view.safeAreaInsets.top+60, width: profilePhotoSize, height: profilePhotoSize).integral
        profileImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        
        usernameField.frame = CGRect(x: 20, y: profileImageView.bottom+10, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+20, width: view.width-40, height: 52)
        
    }
    
    @objc private func didTapChangeProfilePic() {
        //프로필 탭 액션 / 인포에서 카메라, 사진 권한 허용 /아래에 확장자 설정
        didtapProfilePhotoButton()
    }
    
    //회원 가입 버튼 기능 구현 / 사용자가 모든 데이터를 이상없이 전달했을경우 AuthManager를 통해서 계정을 생성하겠습니다.
    @objc private func didTabRegisterButton() {
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
        ///실험 시도 문제가 없다면 사용
        //회원가입시 사용자 이메일이 존재하는 경우 에러를 표시할것 입니다.
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            
            guard !exists else {
                //user already exists
                strongSelf.alertUserRegisterError(message: "해당이메일이 존재하는거 같습니다.")
                return
            }
            // 이메일과 비밀번호를 사용하여 계정을 만들수 있도록 코드를 선언하여 주겠습니다.
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                //오류가 발생하지 않았는지 확인하기 위해 가드문을 추가 하겠습니다. 오류가 발생하면 프린트를 출력 할것입니다.
                guard authResult != nil, error == nil else {
                    print("계정을 만들수 없습니다.")
                    return
                }
                let AppUser = UserModel(username: username, emailAddress: email)
                
                //데이터 베이스에 사진을 등록합니다.
                DatabaseManager.shared.insertNewUser(with: AppUser, completion: { success in
                    if success {
                        guard let image = strongSelf.profileImageView.image,
                              let data = image.pngData() else {
                            return
                        }
                        let filename = AppUser.profilePictureFileName
                        StorageManager.shared.uploadProfilePicture(with: data, fileName: filename, completion: { result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case .failure(let error):
                                print("스토리지 오류 \(error)")
                            }
                        })
                    }
                })
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
            
        })
        
    }
    ///여기까지
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

//MARK: Photo
//숫자를 사용해서 식별 하겠습니다. 아래의 포토피커에서 다중 카메라를 사용하기 위함입니다. 함수 마다 카운트를 설정해서 Int값으로 불리언값을 호출할것입니다.


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @objc func didtapProfilePhotoButton() {
        let actionSheet = UIAlertController(title: "프로필 사진 변경",
                                            message: "프로필 사진을 변경하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    
    //사용자가 사진을 찍거나 카메라 롤에서 사진을 선택한 결과를 얻을수 있도록 합니다.
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
     //이미지 선택이 완료 된 경우
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
            self.profileImageView.image = selectedImage
       
    }
    
    //취소 된 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
