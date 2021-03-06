//
//  NewConversationCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/07.
//

import Foundation
import SDWebImage


final class NewConversationCell: UITableViewCell {

  static let identifier = "NewConversationCell"
    
    //프로필 사진이 될것입니다.
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //검색창의 이름 라벨이 될 것 입니다.
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 50,
                                     height: 50)
        userNameLabel.frame = CGRect(x: userImageView.right + 15,
                                     y: 20,
                                     width: contentView.width - 10 - userImageView.width,
                                     height: 30)
    }
    
    //이미지를 가져옵니다. 중요
    public func configure(with model: SearchResult) {
        self.userNameLabel.text = model.name
        let path = "images/\(model.email)_profile_picture.png"
        
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
