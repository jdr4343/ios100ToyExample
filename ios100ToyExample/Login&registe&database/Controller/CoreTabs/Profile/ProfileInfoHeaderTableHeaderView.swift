//
//  ProfileInfoHeaderTableViewReusableView.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit
import FirebaseStorage
import SDWebImage

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

    //헤더  백그라운드 이미지 뷰 // 구현대기 서버에 올리고 변경가능하게
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //프로필 이미지
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .label
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
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
        let name = UserDefaults.standard.value(forKey: "name") as? String ?? "noName"
        label.text = name
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
        profileCoverImage()

    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var profileChageObserver: NSObjectProtocol?
    //MARK: - Frame
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    

    
    //MARK: - add
    private func addSubViews() {
        addSubview(headerImageView)
        addSubview(profileImageView)
        
        addSubview(postButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    public func profileCoverImage() {
        //사진을 가져옵니다!
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        
        //데이터베이스에게 이메일 전달
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        ///구현대기 프로필이미지 삭제 기능
        // 디렉터리 구조에서 아래 유형의 이미지에 대한 URL을 반환하는 함수를 생성하겠습니다.
        let path = "images/"+filename
        let imageView = profileImageView
        //url을 가져옵니다.
        StorageManager.shared.downloadURL(for: path, completion: { result in
            
            switch result {
            case .success(let url):
                // 이미지 다운로드
                imageView.sd_setImage(with: url, completed: nil)
            case .failure(let error):
                print("Url 다운로드에 실패 했습니다.: \(error)")
            }
        })
        
        let coverimageView = headerImageView
        let coverfilename = "cover_image_" + safeEmail + ".png"
        let coverpath = "cover_images/" + coverfilename
        StorageManager.shared.downloadURL(for: coverpath, completion: { result in
            switch result {
            case .success(let url):
                coverimageView.sd_setImage(with: url, completed: nil)
            case .failure(_):
                print("커버 사진 URL 다운로드에 실패했습니다.")
            }
        })
        
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
