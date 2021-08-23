//
//  PageControlViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit
//수평으로 스크롤되는 콘텐츠를 생성할 것 입니다. 보통 온보딩 뷰에서 앱의 사용방법을 알려주는 튜토리얼이나 어플리케이션 소개에서 많이들 사용됩니다.
class PageControlViewController: UIViewController {

    //페이지 컨트롤을 만든후 페이지의 수를 정하겠습니다.
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .lightGray
        pageControl.numberOfPages = 5
        return pageControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(pageControl)

      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(
            x: 10,
            y: view.height-100,
            width: view.width-20,
            height: 70
        )
    }


}
