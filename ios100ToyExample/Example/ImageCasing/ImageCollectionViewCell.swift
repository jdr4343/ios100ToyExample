//
//  ImageCollectionViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        
        return title
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var badgeImage: UIImage? {
        didSet {
            badgeImageView.image = badgeImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(badgeImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
    }
    
    
}
