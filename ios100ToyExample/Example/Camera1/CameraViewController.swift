//
//  CameraViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/21.
//
//카메라는 시뮬레이터에서 돌리면 오류가 납니다. 폰에 깔아서 해보시길 권장합니다.
//만약 직접 만드신다면 info.plist에서 개인정보 권한을 얻어야 됩니다. Privacy - Camera Usage Description를 추가 해주시면됩니다
import UIKit

class CameraViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.backgroundColor = .brown
        button.setTitle("사진 찍기", for: .normal)
        button.setTitleColor(.white, for: .normal)

        
    }
    @IBAction func didTanButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    
   
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //촬영된 이미지에 대한 참조를 합니다. / 사진이 없을수 있기 때문에 가드문을 통해 바인딩 해주고
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        imageView.image = image
    }
}
