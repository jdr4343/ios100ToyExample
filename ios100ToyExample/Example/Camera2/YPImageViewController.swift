//
//  YPImageViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/21.
//
import YPImagePicker
import UIKit

class YPImageViewController: UIViewController {

    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = profileImage.frame.height/2
        self.profileImage.layer.cornerRadius = profileImage.frame.height/2
        self.pickerButton.layer.cornerRadius = 12
        
        //버튼을 액션으로 끌어오는 방법도 있지만 많이 경험해 보았으므로 코드로 연결해보겠습니다.
        self.pickerButton.addTarget(self, action: #selector(ProfileChangeTapped), for: .touchUpInside)
        }
    
    @objc func ProfileChangeTapped() {
        var config = YPImagePickerConfiguration()
        //비디오 기능은 추가 하지 않았지만 이런 기능도 있다고 보시라고 추가 해뒀습니다.
        config.screens = [.library,.video,.photo]
        //사진이 선택됬을때
        let picker = YPImagePicker(configuration: config)
                   picker.didFinishPicking { [unowned picker] items, _ in
                       if let photo = items.singlePhoto {
                           //프사 이미지 변경
                           self.profileImage.image = photo.image
                        
                       }
                       //사진 선택창 닫기
                       picker.dismiss(animated: true, completion: nil)
                   }
                   //사진 선택창 보여주기
                   present(picker, animated: true, completion: nil)
    }
    
    
}
