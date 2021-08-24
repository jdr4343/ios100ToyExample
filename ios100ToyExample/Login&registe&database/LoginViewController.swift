//
//  LoginViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/24.
//
import SkyFloatingLabelTextField
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
    private let usernamaEmailField: UITextField = {
      let field = UITextField()
        field.placeholder = "이메일"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        //자동으로 대문자가 되지 않게 설정합니다. / 자동완성기능으로 인해 글자가 수정되는 일이 없도록 하겠습니다.
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        //텍스트 뷰의 테두리를 기점으로 잘리게 masksToBounds를 추가해 줍니다. / 코너를 좀 둥글게 만들겠습니다.
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        //테두리를 추가하겠습니다.
        return field
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }
    


}
