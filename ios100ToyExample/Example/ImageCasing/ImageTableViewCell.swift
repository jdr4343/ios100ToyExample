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
        title.font = .boldSystemFont(ofSize: 22)
        title.textColor = .label
        
        return title
    }()
    private let cashimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true

        return imageView
    }()
    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    //didSet 블록은 값이 저장된 직후에 호출됩니다. 이시점에는 속성이 새로운 값이 저장되어 있습니다.그래서 didSet블록에는 이전값이 파라미터로 전달됩니다. 파라미터 이름을 생략한 oldValue가 기본 파라미터로 제공 됩니다.
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var image: UIImage? {
        didSet {
            cashimageView.image = image
        }
    }

    var badgeImage: UIImage? {
        didSet {
            badgeImageView.image = badgeImage
        }
    }
    
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
        cashimageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height/2+30)
        badgeImageView.frame = CGRect(x: 10, y: cashimageView.bottom+10, width: contentView.width/4, height: contentView.width/4)
        titleLabel.frame = CGRect(x: badgeImageView.right+20, y: cashimageView.bottom+10, width: badgeImageView.width*3, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
