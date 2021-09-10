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
        label.font = .systemFont(ofSize:20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
    
    func configure(with viewModel: ExampleCollectionViewModel) {
        contentView.largeContentImage = viewModel.backgroundImage
        label.text = viewModel.name
    }
}
