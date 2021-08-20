//
//  SpinnerViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit
import TransitionButton
//스피너는 ApI를 불러오거나 하는 동기,비동기 작업 수행시에 많이 사용됩니다. 동기와 비동기의 차이점은 간단하게 말하자면 동기는 한가지 일을 모두 완료해야만 다른 작업을 하는 멀티태스킹이 안되는 것이고 비동기는 한가지일을 처리하면서 다른 작업도 수행하고 있는 멀티태스킹이 되는 것입니다.
//식사로 예를 들자면 동기는 밥을 다씹어 넘기고 반찬을 먹는것 이고 비동기는 밥을 씹고 있는와중에 반찬을 집어 먹는것 입니다.
//API정보를 불러오거나 레이턴이 걸릴때 다른코드를 먼저 처리하고 싶으면 비동기 기다리고 싶다면 동기형식으로 코드를 짜면됩니다.

class SpinnerViewController: UIViewController {
    //버튼 생성 / 그거 아시나요? 줄에서 옵션을 누르고 수직으로 드래그하시면 여러개의 문자를 한꺼번에 적을수 있습니다.
    let button: TransitionButton = {
        let button = TransitionButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.backgroundColor = .systemPink
        button.setTitle("시작", for: .normal)
        button.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        //스피너
        button.spinnerColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        button.center = view.center
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        button.startAnimation()
        //1초간 레이턴시를 주는 상황을 만들겠습니다. /그후 스톱애니메이션을 추가하고 / WebVC를 API로 받아온다 생각하고 호출 하겠습니다. / animationStyle은 다양하게 준비되있으니 .을 찍어보시고 모두 호출 해보세요!
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.button.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                print("뷰가 로딩됩니다....")
                let WebVC = WebViewController()
                self.present(WebVC, animated: true, completion: nil)
                
            }
        
        }
    }

}
