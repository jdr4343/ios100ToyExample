//
//  AutoLayoutViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/21.
//

import UIKit

class AutoLayoutViewController: UIViewController {
    //기본 뷰 생성
    private let myView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .link
        return myView
    }()
    private let secondView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemRed
        return myView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "오토레이아웃"
        view.backgroundColor = .white
        view.addSubview(myView)
        //myView에 secondView를 추가 해보겠습니다.
        myView.addSubview(secondView)
        addConstrainsts()
        nextButton()

     
    }
    //레이아웃에 제약을 추가합니다.
    private func addConstrainsts() {
        var constraints = [NSLayoutConstraint]()
        //추가 /화면 양쪽에 고정하여 전체에서 safeArea를 뺀부분을 차지하도록 제약 하겠습니다. safeAreaLayoutGuide를 뺀다면 safeArea를 채우지 않고 모든 화면을 채울것 입니다. 🥕
        //myView
        constraints.append(myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(myView.topAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.topAnchor))
        
        //secondView 상위 앵커를 myView로 바꿔 줍니다. 그리고 constant를 추가하여 여백을 만들어줍니다
//        constraints.append(secondView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor,constant: 120))
//        constraints.append(secondView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor,constant: 120))
//        constraints.append(secondView.bottomAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.bottomAnchor,constant: 120))
//        constraints.append(secondView.topAnchor.constraint(equalTo:
//            myView.safeAreaLayoutGuide.topAnchor,constant: 120))
        //실행해 보시면 보다시피 constant간의 충돌이 이루어져 우리가 생각한 뷰를 안보여주는 모습을 볼수 있습니다.
        
        
        //뷰를 절반으로 나누겠습니다. 이렇게 하면 myView의 폭과 높이가 절반인 값을 secondView가 가지게 됩니다.
        constraints.append(secondView.widthAnchor.constraint(equalTo: myView.widthAnchor,multiplier: 0.5))
        constraints.append(secondView.heightAnchor.constraint(equalTo: myView.heightAnchor,multiplier: 0.5))
        //화면 중심에 고정해보겠습니다.
        constraints.append(secondView.centerYAnchor.constraint(equalTo: myView.centerYAnchor))
        constraints.append(secondView.centerXAnchor.constraint(equalTo: myView.centerXAnchor))
        
        
        //작동
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func nextButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .done, target: self, action: #selector(nextViewButton))
    }
    @objc private func nextViewButton() {
        let VC = SnapkitViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
}
/*
 정리
 Anchor을 추가해 뷰를 고정할수있다.
 Anchor에 constant를 추가해서 여백을 줄수 있다. 그러나 뷰의 크기를 교체하는 것은 아니고 뷰가 이동하기 때문에 4방향 모두 여백을 줄경우 충돌이 일어난다
 Anchor에 murtiplier을 추가하여 크기를 줄이거나 늘릴수 있습니다.
 centerYAnchor,centerXAnchor추가하여 수평과 수직을 잡을수 있다.
 잘모르는 부분이라 지금까지는 주먹구구 식으로 중심에 맞추려고 노력했었는데 앞으로는 오토 레이아웃을 사용해서 중심을 잡아봐야겠다..
 */
