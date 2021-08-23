//
//  CustomTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    private let _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = .lightGray
        _switch.isOn = true
        return _switch
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(_switch)
        contentView.addSubview(myImageView)
        contentView.addSubview(label)
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //라벨과 이미지가 순서대로 전달되도록 하겠습니다.
    public func configure(text: String, imageName: String) {
        label.text = text
        myImageView.image = UIImage(named: imageName)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        myImageView.image = nil
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.frame.size.height - 6
        let switchSize = _switch.sizeThatFits(contentView.frame.size)
        _switch.frame = CGRect(x: 5,
                               y: (contentView.height - switchSize.height)/2,
                               width: switchSize.width,
                               height: switchSize.height
        )
        label.frame = CGRect(x: 20+_switch.width,
                             y: 0,
                             width: contentView.width - 10 - _switch.width - imageSize,
                             height: contentView.height
        )
        myImageView.frame = CGRect(x: contentView.frame.size.width - imageSize,
                                   y: 3,
                                   width: imageSize,
                                   height: imageSize)
    }
    
    
    
    
}
