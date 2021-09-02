//
//  ProfileInfoHeaderTableViewReusableView.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit
import FirebaseStorage

//프로토콜을 선언하여 ProfileViewController에서 버튼의 액션을 지정해주겠습니다.
protocol ProfileInfoHeaderTableHeaderViewDelegate: AnyObject {
    func didTapPostButton()
    func didTapEditProfileButton()
}



//헤더를 만들겠습니다.
class ProfileInfoHeaderTableHeaderView: UIView{

    static let identifier = "ProfileInfoHeaderTableHeaderView"
    
    //프로토콜 연결
    public weak var delegate: ProfileInfoHeaderTableHeaderViewDelegate?
    
    //MARK: - 요소 추가

    //헤더  백그라운드 이미지 뷰
    private let headerImageView: UIView = {
        let imageView = UIView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //프로필 이미지
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "테스트프로필")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
 
    
    
    //게시물 버튼
    private let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemBackground
        return button
    }()
    //프로필 편집 버튼
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 변경", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    //이름 라벨
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "신지훈"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    //자기소개 라벨
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 계정 입니다\nGit hub: https://github.com/jdr4343 \n \nNotion: https://www.notion.so/9efbaec014d84700a6e17733ad829447?v=cb2389fba533469086f9798c5b23a75f"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 10
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        //MARK: - 구현대기 / 백 그라운드 이미지 변경
        //프로필 백 그라운드를 지정합니다. 가능하다면 사용자들이 지정하는 데로 변경하고 싶으나 필자의 기술적인 한계의 문제로 구현 안될수도 있습니다.
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
        let profilePhotoSize  = width/3.5
        profileImageView.frame = CGRect(x: 0, y: 0, width: profilePhotoSize, height: profilePhotoSize).integral
        profileImageView.layer.cornerRadius = profilePhotoSize/2.0
        profileImageView.center = center
        
        //사진을 가져옵니다!
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }

        //데이터베이스에게 이메일 전달
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        //모듈을 유지하도록 하는 함수 추가 / 디렉터리 구조
        let path = "images/"+filename
        let imageView = profileImageView

        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let url):
                // 이미지 다운로드
                strongSelf.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Faild to get download url: \(error)")
            }
        })

        
        //라벨
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        nameLabel.frame = CGRect(x: 5, y: 5 + profileImageView.bottom, width: width-16, height: 40).integral
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width-16, height: bioLabelSize.height).integral
        
        
        let buttonHeight = profilePhotoSize/4
        editProfileButton.frame = CGRect(x: 5, y: bioLabel.bottom+10, width: width-16, height: buttonHeight).integral
        postButton.frame = CGRect(x: profileImageView.right+(profilePhotoSize-20),
                                  y: headerImageView.bottom,
                                  width: 50,
                                  height: 50).integral
        
    }
    
    //다운로드 이미지 기능
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        })
        .resume()
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
        delegate?.didTapPostButton()
    }
    @objc private func didTapEditProfileButton() {
        delegate?.didTapEditProfileButton()
        
    }
    
   
    
    
}
