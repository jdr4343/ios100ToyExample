//
//  ThirdTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/13.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    static let identifier = "ThirdTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        label.frame = CGRect(x: 105, y: 5, width: contentView.width-105, height: 100)
    }
    
    
    public func configure(with imageName: String, text: String) {
        myImageView.image = UIImage(named: imageName)
        label.text = text
    }
}
