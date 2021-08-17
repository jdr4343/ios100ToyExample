//
//  FontPickerViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class FontPickerViewController: UIViewController, UIFontPickerViewControllerDelegate {
    
    //라벨 생성
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "안녕하세요 저는 100가지 예제파일을 만들고 있습니다. 저도 공부하는 입장인데 아무래도 ios의 예제파일이 좀 부족한거 같기도 하고 공부하기도 힘들더라고요.. 그래서 이왕 제가 공부하는 김에 예제파일을 만들자 싶어서 만들게 되었습니다. 예제파일의 출저는 어떤 부분은 제가 직접 찾아가며 만들기도 했고 유튜브를 보며 따라치기도 했습니다. 저도 배우는 입장이다 보니 제 코멘트를 너무 믿지 마시고 보이는 족족 검색해서 자신만의 지식으로 만드시길 바랍니다.우리 모두 ..화이팅 ㅜㅜ"
        return label
    }()
    //가끔 코드가 난잡해 보일때는 드래그 한후 ctrl + I를 해주시면 정갈하게 정리됩니다! cmd + shift + O를 하시면 파일을 검색을 할수 있죠!
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("폰트 선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(button)
        view.backgroundColor = .white
        //#selector에 들어갈 함수는 @objc를 추가해주어야 합니다!
        button.addTarget(self, action: #selector(didTapPickFont), for: .touchUpInside )
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width-20,
            height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom-100)
        button.frame = CGRect(
            x: 20,
            y: view.frame.size.height-100,
            width: view.frame.size.width-40,
            height: 50)
    }
    //폰트 선택기 구현
    @objc func didTapPickFont() {
        let configuration = UIFontPickerViewController.Configuration()
        //configuration.includeFaces = false
        let vc = UIFontPickerViewController(configuration: configuration)
        vc.delegate = self
        present(vc, animated: true)
    }
    //테이블뷰 델리게이트랑 같은 개념처럼 생각 하시면 좀더 쉽게 이해하실수 있습니다. 이름 그대로 이해하시면 됩니다. ios의 스위프트에서는 구문 자체가 영어로서 어느정도 말이 가능하게 만들기 때문에 함수의 이름대로 닫힌다면? 선택된다면? 이런식으로 셍긱히고 힘수의 스코프 안에서 뭐뭐 할것이다 이런식으로 생각하고 나서 부터는 저는 이해가 잘된거 같습니다.
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        //사용자가 선택하지 않았을경우를 생각 해서 언래핑 해주고 폰트에 선택된 폰트 데이터를 저장하겠습니다.
        guard let font = viewController.selectedFontDescriptor else { return }
        //라벨에 선택된 폰트 데이터를 전달 하겠습니다.
        label.font = UIFont(descriptor: font, size: 20 )
    }
}
