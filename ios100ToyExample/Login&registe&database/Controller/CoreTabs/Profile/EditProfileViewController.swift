//
//  EditProfileViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit
import SafariServices

//프로필 변경 화면 입니다.
final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var modles = [[UserModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
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
    
    private func configureModels() {
        //프로필 사진, 프로필 사진 백그라운드 ,이름, 자기소개
    }
    
    //MARK: - Header
    //헤더 생성
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
            //사용자의 프로필의 현재사진을 보여주고 그것을 탭 하면 사용자가 자신의 사진을 변경할수 있도록 하는 버튼을 추가하겠습니다
        let size = header.height/1.5
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
        let actionSheet = UIAlertController(title: "사진 변경",
                                            message: "사진을 변경하시겠습니까?",
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



extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource, EditProfileTableViewCellDelegate {

    
    
   
    
    
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "테스트"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return view.height/3
        }
    
    
    
    //MARK: - EditProfileTableViewCellDelegate / 구현대기
    
    func formTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField updateModel: UserModel) {
        //모델을 업데이트 합니다.
    }
    
    
}
