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
        field.selectedTitleColor = .darkGray
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
        imageView.image = UIImage(named: "기본이미지")
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private var selectedHeaderImage: UIImage?
    
    ///게시물의 내용을 적을 텍스트 뷰입니다.
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        view.addSubview(titleField)
        view.addSubview(textView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        
        configureButton()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleField.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.width-40, height: 50)
        headerImageView.frame = CGRect(x: 5, y: titleField.bottom+5, width: view.width-10, height: 300)
        textView.frame = CGRect(x: 20, y: headerImageView.bottom+10, width: view.width-40, height: view.height-210-view.safeAreaInsets.top)
        
    }
    
    private func configureButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "게시",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapPost))
    }
    
    @objc private func didTapHeader() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker,animated: true)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPost() {
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              let email = UserDefaults.standard.string(forKey: "email"),
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            let alert = UIAlertController(title: "게시물의 세부 정보를 입력하십시오.", message: "제목과 글,사진이 정상적으로 작성되었는지 확인 하여 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        print("게시물을 작성했습니다...")
        let newPostId = UUID().uuidString
        //헤더 이미지 업로드
        StorageManager.shared.uploadBlogHeaderImage(email: email, image: headerImage, postId: newPostId) { success in
            guard success else {
                return
            }
            StorageManager.shared.downloadUrlForPostHeader(email: email, postId: newPostId) { url in
                guard let headerUrl = url else {
                    print("URL을 업로드 하는것에 실패 했습니다. - Post")
                    return
                }
                //DB에 게시물 삽입
                
                let post = BlogPost(identifier: newPostId,
                                    title: title,
                                    timestamp: Date().timeIntervalSince1970,
                                    headerImageUrl: headerUrl,
                                    text: body)
                DatabaseManager.shared.insert(blogPost: post, email: email) { [weak self] posted in
                    guard posted else {
                        print("새로운 게시물을 올리지 못했습니다. - Post")
                        return
                    }
                    DispatchQueue.main.async {
                        self?.didTapCancel()
                    }
                }
            }
        }
        
    }
}

extension CreaateNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}
