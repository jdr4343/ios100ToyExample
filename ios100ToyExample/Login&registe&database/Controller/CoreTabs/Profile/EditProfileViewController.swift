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
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/2.5).integral)
            //사용자의 프로필의 현재사진을 보여주고 그것을 탭 하면 사용자가 자신의 사진을 변경할수 있도록 하는 버튼을 추가하겠습니다
        let size = header.height/1.5
        
        //프로필 백그라운드
        let ProfileBackgroundPhotoButton = UIButton(frame: CGRect(x: 0, y: 0, width: header.width, height: header.height))
        header.addSubview(ProfileBackgroundPhotoButton)
        ProfileBackgroundPhotoButton.layer.masksToBounds = true
        ProfileBackgroundPhotoButton.setBackgroundImage(UIImage(named: "헤더이미지"), for: .normal)
        ProfileBackgroundPhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        ProfileBackgroundPhotoButton.addTarget(self, action: #selector(didTapProfileBackgroundPhotoButton), for: .touchUpInside)
        
        
        //프로필 변경
        let ProfilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size, height: size))
        header.addSubview(ProfilePhotoButton)
        ProfilePhotoButton.layer.masksToBounds = true
        ProfilePhotoButton.layer.cornerRadius = size/2.0
        ProfilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        ProfilePhotoButton.tintColor = .label
        ProfilePhotoButton.layer.borderWidth = 1
        ProfilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        ProfilePhotoButton.addTarget(self, action: #selector(didtapProfilePhotoButton), for: .touchUpInside)
        
        return header
    }
    
    
    
    //MARK: - 구현대기
    @objc func didTapSave() {
        print("변경사항을 저장 할것입니다.")
    }
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didtapProfilePhotoButton() {
        let actionSheet = UIAlertController(title: "프로필 사진 변경",
                                            message: "프로필 사진을 변경하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { _ in
            print("구현 대기")
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { _ in
            print("구현 대기")
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    @objc func didTapProfileBackgroundPhotoButton() {
        let actionSheet = UIAlertController(title: "배경화면 변경",
                                            message: "배경화면을 변경하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default, handler: { _ in
            print("구현 대기")
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { _ in
            print("구현 대기")
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        present(actionSheet, animated: true)
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
