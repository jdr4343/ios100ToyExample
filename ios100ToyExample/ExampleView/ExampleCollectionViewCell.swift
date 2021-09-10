//
//  ExampleCollectionViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit

class ExampleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExampleCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        imageView.frame = contentView.bounds
    }
    
    func configure(with viewModel: ExampleCollectionViewModel) {
        label.text = viewModel.name
        imageView.image = UIImage(named: viewModel.backgroundImage)
    }
}
