//
//  PageControlViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit
//수평으로 스크롤되는 콘텐츠를 생성할 것 입니다. 보통 온보딩 뷰에서 앱의 사용방법을 알려주는 튜토리얼이나 어플리케이션 소개에서 많이들 사용됩니다.
class PageControlViewController: UIViewController {

    private let scrollView = UIScrollView()
    
    //페이지 컨트롤을 만든후 페이지의 수를 정하겠습니다.
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .lightGray
        pageControl.numberOfPages = 5
        return pageControl
    }()
    
    //이미지는 찾기가 힘들어 같은 이미지를 사용하고 배경색깔을 통해 화면 전환이 된다는걸 표시하겠습니다.그냥 이미지가 있으면 좀더 까리 하다.. 이런느낌..
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "온보딩1")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //페이지 컨트롤과 스크롤뷰 연결
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        scrollView.delegate = self
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        view.addSubview(imageView)
        scrollView.backgroundColor = .red
        

      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(
            x: 10,
            y: view.height-100,
            width: view.width-20,
            height: 70
        )
        scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
              height: view.height-100
        )
    
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width , height: scrollView.height-100)
        
        
       if scrollView.subviews.count == 2 {
            configurescrollView()
        }
    }
    //페이지 컨트롤 / 현재 페이지의 값이 바뀔때마다 호출됩니다.
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.width, y: 0), animated: true)
    }
    
    
    
    
    
    
    
    //스크롤 뷰의 내용을 구성하는 함수 생성
    private func configurescrollView() {
        scrollView.contentSize = CGSize(width: view.width * 5, height: scrollView.height)
        //페이지 생성
        scrollView.isPagingEnabled = true
        //색깔 배열 /아마 이미지 배열을 만들어서 전달하면 컬러배열과 마찬가지로 스크롤링 될거 같은데 나중에 각잡고 만들때 해봐야겠습니다.
        let colors:[UIColor] = [
            .white,
            .systemBlue,
            .systemPink,
            .systemTeal,
            .systemGray
        ]
        
        
        for x in 0..<5 {
            let page = UIView(frame: CGRect(x: CGFloat(x) * view.width,
                                            y: 0,
                                            width: view.width,
                                            height: scrollView.height))
            page.backgroundColor = colors[x]
            scrollView.addSubview(page)
        }
    }


}
//스크롤을 할때 페이지 컨트롤러도 같이 움직이기 하기 위해서 델리게이트를 연결
extension PageControlViewController: UIScrollViewDelegate {
    //사용자가 어떤 페이지에 있는지 계산
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.width)))
    }
}
