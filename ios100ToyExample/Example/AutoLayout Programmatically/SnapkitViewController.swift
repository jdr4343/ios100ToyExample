//
//  SnapkitViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/22.
//

//위의 오토레이아웃을 스냅킷으로 동일시하게 작성 해보겠습니다. 스냅킷은 오토레이아웃을 편하게 도와주는 도우미 프레임워크의 일종으로 코드를 좀더 간결하게 작성할수 있도록 도와줍니다.사람마다 차이점이 있지만 둘중 편한것을 사용하시면 될거 같습니다.

import UIKit
import SnapKit

class SnapkitViewController: UIViewController {
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
        title = "스냅킷"
        view.backgroundColor = .white
        view.addSubview(myView)
        //myView에 secondView를 추가 해보겠습니다.
        myView.addSubview(secondView)
        addConstrainsts()
    }
    
    
    private func addConstrainsts() {
        //보다 시피 읽기에는 좀 불편해진거 같긴한대 읽다보면 적응 될거 같고 훨씬 간단한거 같네요! 자세한 내용이 필요하시다면 깃헙에서 검색 해보시길 바래요!
        myView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    
        secondView.snp.makeConstraints { make in
            make.height.equalTo(myView).multipliedBy(0.5)
            make.width.equalTo(myView).multipliedBy(0.5)
            make.center.equalTo(myView)
            
        }

    }
    
}
