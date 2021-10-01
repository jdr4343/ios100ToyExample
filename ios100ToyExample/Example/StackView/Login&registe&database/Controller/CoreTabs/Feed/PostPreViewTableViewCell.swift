//
//  PostPreViewTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/20.
//

import UIKit

class PostPreViewTableViewCellViewModel {
    let title: String
    let body: String
    let imageUrl: URL?
    var imageData: Data?
    
    init(title: String, body: String, imageUrl: URL?) {
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
    }
}


class PostPreViewTableViewCell: UITableViewCell {

    static let identifier = "PostPreViewTableViewCell"
    
//    private let postImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.masksToBounds = true
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 20
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    private let postTitleLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = .boldSystemFont(ofSize: 16)
//        return label
//    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 //라인의 행의 수를 나타냅니다 0을 주면 제한이 없어집니다!
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true //이미지를 크기내에서 잘라 주기 위해서 추가해줍니다.
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        postImageView.frame = CGRect(x: 10,
//                                     y: 5,
//                                     width: contentView.height-10,
//                                     height: contentView.height-10)
//        postTitleLabel.frame = CGRect(x: contentView.height-10+20,
//                                      y: 5,
//                                      width: contentView.width-10-10-postImageView.width,
//                                      height: contentView.height-10)
        postTitleLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width-170,
            height: 70
        )
        bodyLabel.frame = CGRect(
            x: 10,
            y: 70,
            width: contentView.width-170,
            height: contentView.height/2
        )
        postImageView.frame = CGRect(
            x: contentView.width - 150,
            y: 5,
            width: 140,
            height: contentView.height-10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        bodyLabel.text = nil
        postImageView.image = nil
    }
    
    func configure(with viewModel: PostPreViewTableViewCellViewModel) {
        postTitleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        if let data = viewModel.imageData {
            postImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.postImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
    }
}
