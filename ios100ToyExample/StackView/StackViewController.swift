//
//  StackViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/21.
//

import UIKit
//스택뷰는 세로 또는 가로로 여러 뷰를 쌓는 작업 입니다. 간격과 같은 것을 제어하고 오토레이아웃을 사용하여 테이블뷰와 다르게 한화면에 아이템을 빠르게 배치할수 있습니다.
class StackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createStackView()
        
    }
    
    private func createStackView() {
        //스택뷰에 여러가지 추가 해보겠습니다.
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
        imageView.contentMode = .scaleAspectFit
        //너비와 높이에 대한 제약 추가 / 너비는 같으며 높이는 일반뷰의 3분의1로 만들겠습니다.
        imageView.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.height/3).isActive = true
        
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = "오토레이아웃!!저는 곧 훠궈를 먹으러 갑니다..서울대입구에는 소백냥이라는 맛집이 있어요!ㅎㅎ;🐥"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21, weight: .bold)
        //제약 추가 /
        label.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        label.heightAnchor.constraint(equalToConstant: view.height/3).isActive = true
        
        let label2 = UILabel()
        label2.backgroundColor = .yellow
        label2.text = "아.. 빨리 먹고 싶다 거기다가 무한리필이거던여..🐥"
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.font = .systemFont(ofSize: 21, weight: .bold)
        //제약 추가 / 너비는 같고 높이는 100입니다! 매개체를 전달하지 않아도 값을 줄수 있었네요!
        label2.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //기본적인 스택뷰를 생성하고 위에서 만든 요소들을 추가해 줍니다.
        let stackView = UIStackView(arrangedSubviews: [imageView, label, label2])
        stackView.backgroundColor = .white
        stackView.frame = view.bounds
        
        //뷰 구성하기 / axis속성을 추가해서 하위보기를 어떤 방향으로 배치한다는걸 스택뷰에 알려줍니다.
        stackView.axis = .vertical
        //distribution은 요소들을 어떤 방식으로 배치 할지를 정합니다. /이 속성을 사용하게 된다면 오토레이아웃을 사용하지 않아도 됩니다! 왜나하면 아래의 속성으로 이미 요소를 배치 했기때문이죠! 커스텀을 하고 싶으시다면 아래의 속성을 주석 처리 하시고 제약을 이리저리 바꿔 보세요!
        stackView.distribution = .fillEqually
        //spacing은 요소간의 간격을 조절합니다.
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
    }

}
