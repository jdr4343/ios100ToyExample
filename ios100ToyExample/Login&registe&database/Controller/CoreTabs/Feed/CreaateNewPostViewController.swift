//
//  CreaateNewPostViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/20.
//

import UIKit
import SkyFloatingLabelTextField

class CreaateNewPostViewController: UIViewController {

    ///게시물의 제목을 적을 텍스트 필드 입니다.
    private let titleField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "제목"
        field.title = "제목을 작성해 주세요."
        field.returnKeyType = .next
        field.leftViewMode = .always
        //자동으로 대문자가 되지 않게 설정합니다. / 자동완성기능으로 인해 글자가 수정되는 일이 없도록 하겠습니다.
        field.autocapitalizationType = .words
        field.autocorrectionType = .no
        field.tintColor = .darkGray
        field.selectedTitleColor = .systemPink
        field.selectedLineColor = .darkGray
        field.textColor = .label
        field.lineColor = .lightGray
        field.lineHeight = 1.0
        field.selectedLineHeight = 2.0
        field.layer.masksToBounds = true
        return field
    }()
    ///게시물 상단에 자리할 이미지 입니다
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "배경2")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    ///게시물의 내용을 적을 텍스트 뷰입니다.
    private let textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "게시",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapPost))
        configureButton()
      
    }
    
    private func configureButton() {
        
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapPost() {
        
    }
}
