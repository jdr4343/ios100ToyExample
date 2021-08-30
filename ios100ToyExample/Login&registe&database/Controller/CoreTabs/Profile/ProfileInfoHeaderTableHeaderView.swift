//
//  ProfileInfoHeaderTableViewReusableView.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit
//프로토콜을 선언하여 ProfileViewController에서 버튼의 액션을 지정해주겠습니다.
protocol ProfileInfoHeaderTableHeaderViewDelegate: AnyObject {
    func didTapPostButton(_ header: ProfileInfoHeaderTableHeaderView)
    func didTapEditProfileButton(_ header: ProfileInfoHeaderTableHeaderView)
}



//헤더를 만들겠습니다.
class ProfileInfoHeaderTableHeaderView: UITableViewHeaderFooterView{

    static let identifier = "ProfileInfoHeaderTableHeaderView"
    
    public weak var delegate: ProfileInfoHeaderTableHeaderViewDelegate?
    //MARK: - 요소 추가

    //헤더  백그라운드 이미지 뷰
    private let headerImageView: UIView = {
        let imageView = UIView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    //프로필 이미지
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //게시물 버튼
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시물", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    //프로필 편집 버튼
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 변경", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    //이름 라벨
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "신지훈"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    //자기소개 라벨
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 계정 입니다"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Frame
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //프로필 백 그라운드를 지정합니다. 가능하다면 사용자들이 지정하는 데로 변경하고 싶으나 기술적인 한계의 문제로 구현안될수도 있습니다.
        headerImageView.frame = CGRect(x: 0, y: 0, width: width, height: height/2)
        
        UIGraphicsBeginImageContext(self.headerImageView.frame.size)
        UIImage(named: "헤더이미지")?.draw(in: self.headerImageView.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.headerImageView.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            print("프로필 - 백그라운드 이미지가 잘못되었습니다.")
         }
        
        //프로필 포토 사이즈
        let profilePhotoSize  = width/3
        profileImageView.frame = CGRect(x: 0, y: 0, width: profilePhotoSize, height: profilePhotoSize).integral
        profileImageView.layer.cornerRadius = profilePhotoSize/2.0
        profileImageView.center = center
        
//        let buttonHeight = profilePhotoSize/2
//        let buttonWidth = (width-10-profilePhotoSize)/3
//        postButton.frame
    }
    
    
    
    
    
    
    //MARK: - add
    private func addSubViews() {
        addSubview(headerImageView)
        addSubview(profileImageView)
        addSubview(postButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    //여기에서 위에서 만든 델리게이트를 연결해줍니다.
    private func addButtonAction() {
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
        
    @objc private func didTapPostButton() {
        delegate?.didTapPostButton(self)
    }
    @objc private func didTapEditProfileButton() {
        delegate?.didTapEditProfileButton(self)
    }
    
    
}
