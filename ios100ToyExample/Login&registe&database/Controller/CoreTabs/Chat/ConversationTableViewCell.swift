//
//  ConveersationTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/03.
//

import UIKit
import SDWebImage

class ConversationTableViewCell: UITableViewCell {

  static let identifier = "ConversationTableViewCell"
    
    //프로필 사진이 될것입니다.
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //채팅창의 이름 라벨이 될 것 입니다.
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    //채팅창의 말풍선의 라벨이 될 것 입니다.
    private let userMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userMessageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 60,
                                     height: 60)
        userNameLabel.frame = CGRect(x: userImageView.right + 10,
                                     y: 10,
                                     width: contentView.width - 10 - userImageView.width,
                                     height: (contentView.height-30)/2)
        userMessageLabel.frame = CGRect(x: userImageView.right + 10,
                                        y: userNameLabel.bottom+5,
                                        width: contentView.width-10-userImageView.width,
                                        height: (contentView.height-30)/2)
    }
    
    public func configure(with model: Conversation) {
        self.userMessageLabel.text = model.latestMessage.text
        self.userNameLabel.text = model.name
        let path = "images/\(model.otherUserEmail)_profile_picture.png"
        
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                //다운로드 URL을 제공합니다.
                DispatchQueue.main.async {
                    self?.userImageView.sd_setImage(with: url, completed: nil)
                }
                
            case .failure(let error):
                print("이미지 URL을 가져오지 못했습니다.\(error)")
            }
        })
    }
}
