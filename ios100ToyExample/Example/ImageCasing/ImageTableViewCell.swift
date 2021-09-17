//
//  ImageTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    static let identifier = "ImageTableViewCell"
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        
        return title
    }()
     let cashimageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
//    var title: String? {
//        didSet {
//            titleLabel.text = title
//        }
//    }
//
//    var image: UIImage? {
//        didSet {
//            cashimageView.image = image
//        }
//    }
//
//    var badgeImage: UIImage? {
//        didSet {
//            badgeImageView.image = badgeImage
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cashimageView)
        contentView.addSubview(badgeImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height/2+30)
        badgeImageView.frame = CGRect(x: 10, y: imageView.bottom+10, width: contentView.width/4, height: contentView.width/4)
        titleLabel.frame = CGRect(x: badgeImageView.right+20, y: imageView.bottom+10, width: badgeImageView.width*3, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
