//
//  PDFkitViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit
import PDFKit

class PDFkitViewController: UIViewController, PDFViewDelegate {
    
    let pdfView = PDFView()
   
    @IBOutlet weak var pdfViewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        pdfViewView.addSubview(pdfView)
        //PDF로 문서화 / 리소스에는 파일의 이름을 뒤에는 확장자를 넣어줍니다. 이것이 아마 mp3였다면 pdf가 아닌 mp3가 들어가게 되겠죠. / 옵셔널 값을 언래핑 해주어야 합니다.가드문을 이용하여 언래핑 할것입니다
        guard let url = Bundle.main.url(forResource: "Intro to Swift", withExtension: "pdf") else {
            print("파일의 이름이 잘못됬는지 확장자가 잘 기입 됬는지 확인해주세요! 콘솔로그 단축키는 ctrl + shift + Y 입니다!")
            return
        }
        guard let document = PDFDocument(url: url) else {
            print("문서화가 실패 했습니다. 이런식으로 디버깅을 위한 콘솔로그를 남기면 버그를 고치기 쉽습니다.")
            return
        }
        pdfView.document = document
        pdfView.delegate = self
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.frame
        
    }
    @objc func closePDFkit() {
        
    }
    
}



