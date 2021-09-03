//
//  EditProfileViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit

//프로필 변경 화면 입니다.
final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        tableView.register(EditTextViewTableViewCell.self, forCellReuseIdentifier: EditTextViewTableViewCell.identifier)
        return tableView
    }()
    
    private let ProfileBackgroundPhotoButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIImage(named: "헤더이미지"), for: .normal)
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.addTarget(self, action: #selector(didTapProfileBackgroundPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private let ProfilePhotoButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        button.backgroundColor = .lightGray
        button.tintColor = .white
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(didtapProfilePhotoButton), for: .touchUpInside)
        return button
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = createTableHeaderView()
        configureModels()
        //네비게이션 바
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - 구현대기 / 텍스트 필드가 전해준 값 전달
    
    private func configureModels() {
    
        let sectionLabel1 = ["이름"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabel1 {
          let model = EditProfileFormModel(label: label, placeholder: "\(label)을(를) 작성해주세요.", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
       //  이름, 자기소개 //여기에서 value는 텍스트 필드가 토해낸 값입니다.
        let sectionLabel = ["지기소개"]
        var section = [EditProfileFormModel]()
        for label in sectionLabel {
            let model = EditProfileFormModel(label: label, placeholder: "\(label)을(를) 작성해주세요.", value: nil)
            section.append(model)
        }
        models.append(section)
    }

    //MARK: - Header
    //헤더 생성
    fileprivate func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/2.5).integral)
            //사용자의 프로필의 현재사진을 보여주고 그것을 탭 하면 사용자가 자신의 사진을 변경할수 있도록 하는 버튼을 추가하겠습니다
        let size = header.height/2
        
        //백그라운드 이미지
        header.addSubview(ProfileBackgroundPhotoButton)
        ProfileBackgroundPhotoButton.frame = CGRect(x: 0, y: 0, width: header.width, height: header.height)
        
        //프로필 변경
        header.addSubview(ProfilePhotoButton)
        ProfilePhotoButton.frame = CGRect(x: (view.width-size)/2,
                                           y: (header.height-size)/2,
                                           width: size, height: size)
        ProfilePhotoButton.layer.cornerRadius = size/2.0
        
        
        
        
        
        
        return header
    }
    
    
    
    //MARK: - 구현대기
    @objc func didTapSave() {
        print("변경사항을 저장 할것입니다.")
    }
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
}



extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource, EditProfileTableViewCellDelegate, EditTextViewTableViewCellDelegate {
   
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
       
        let subSection = indexPath.section
        if subSection == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.identifier, for: indexPath) as? EditProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.configuer(with: model)
            cell.delegate = self
            return cell
        }
        else if subSection == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditTextViewTableViewCell.identifier,for: indexPath) as? EditTextViewTableViewCell else {
                return UITableViewCell()
            }
            cell.configuer(with: model)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section
        if subSection == 0 {
            //name
            return 85
        } else if subSection == 1 {
            //bio
            return 250
        }
        return 0
    }
    
    //MARK: - EditProfileTableViewCellDelegate / 구현대기
    
    func formTextFieldTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        //모델을 업데이트 합니다.
    }
    
    func formTextViewTableViewCell(_ cell: EditTextViewTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        //모델을 업데이트 합니다.
    }
    
}

//MARK: Photo
//숫자를 사용해서 식별 하겠습니다. 아래의 포토피커에서 다중 카메라를 사용하기 위함입니다. 함수 마다 카운트를 설정해서 Int값으로 불리언값을 호출할것입니다.
var count = 0

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    ///구현대기 프로필 이미지 삭제기능을 추가하고 이미지를 변경하는 작업을 추가 해야됨 아마 예측 가능 시나리오는 데이터베이스에서 이미지 URL을 지워주는 delete 기능을 활성화하고 이미지를 지워줘야할거 같음. 그리고 이미지를 변경하는 동시에 이미지가 delete되는 기능을 구현해야함 그러함으로서 이미지를 변경하게 되면 이미지가 지워지면서 자동으로 기본이미지로 변경되고 교체했을경우 데이터베이스에 저장되는 기능을 구현할것임 물론헤더 또한 저장해줘야하는데 아마 이름 형식을 바꿔주면 되지 않을까 싶음..또한 라벨또한 데이터베이스에 저장할수 있도록 생각해봐야함..아마 채팅기능이랑 비슷하지 않을까 싶음 대화 구현 방식을 참조해봐야 할거 같음
    @objc func didtapProfilePhotoButton() {
        count = 1
        let actionSheet = UIAlertController(title: "프로필 사진 변경",
                                            message: "프로필 사진을 변경하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    @objc func didTapProfileBackgroundPhotoButton() {
        count = 2
        let actionSheet = UIAlertController(title: "배경화면 변경",
                                            message: "배경화면을 변경하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { [weak self] _ in
            self?.presentPhotoPicker()
           
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    //사용자가 사진을 찍거나 카메라 롤에서 사진을 선택한 결과를 얻을수 있도록 합니다.
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
     //이미지 선택이 완료 된 경우
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        if count == 1 {
            self.ProfilePhotoButton.setImage(selectedImage, for: .normal)
        } else if count == 2 {
            self.ProfileBackgroundPhotoButton.setImage(selectedImage, for: .normal)
        }
        
    }
    
    //취소 된 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
