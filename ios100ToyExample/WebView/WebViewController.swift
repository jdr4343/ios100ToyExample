//
//  WebViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        //웹에 쓰일 주소 불러오기
        guard let url = URL(string: "https://github.com/jdr4343") else {
            print("웹을 불러오지 못했습니다! 주소를 확인해주세요!")
            return
        }
        webView.load(URLRequest(url: url))

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }


}
