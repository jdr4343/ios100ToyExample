//
//  KeyboardToolBarViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

class KeyboardToolBarViewController: UIViewController {
    
   private let field: UITextField = {
        let field = UITextField()
        //투명 글을 추가 해줍니다! 보통 저희가 로그인 할때 email, password같은걸 placeholder로 지정하지요!
        field.placeholder = "이름을 적어주세여 ..🥰"
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        //기본적으로 디폴트 값의 툴바는 아무것도 보여주지 않습니다.저희는 완료 버튼을 추가하겠습니다.
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,//플렉시블은 생각보다 자주 쓰입니다.공간을 줄때 사용됩니다.
            target: self,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        //여러가지 기능의 버튼을 또 추가할수 있습니다! 이 버튼을 통해 뷰를 띄울수도 있고 웹을 띄울수도 있습니다!
        let Button1 = UIBarButtonItem(
            title: "😊",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        let Button2 = UIBarButtonItem(
            title: "😝",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        let Button3 = UIBarButtonItem(
            title: "👀",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        toolBar.items = [flexibleSpace, Button1, Button2, Button3,doneButton,]
        toolBar.sizeToFit()
        return toolBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(field)
        //필드에 툴바 삽입
        field.inputAccessoryView = toolBar
        
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(x: 20 , y: 30 + view.safeAreaInsets.top, width: view.width-40, height: 50)
        toolBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
    }
    
    @objc func didTapDone() {
        field.resignFirstResponder()//키보드를 제거 할떄 주로 사용 합니다.
    }
}
