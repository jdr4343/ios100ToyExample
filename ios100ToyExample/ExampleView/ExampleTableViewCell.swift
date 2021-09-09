//
//  ExampleTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

    static let identifier = "ExampleTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "테스트"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExampleCollectionViewCell.self, forCellWithReuseIdentifier: ExampleCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let collectionSize = (contentView.height/5)*4-10
        titleLabel.frame = CGRect(x: 20, y: 10, width: contentView.width-20, height: contentView.height/6)
        collectionView.frame = CGRect(x: 10, y: titleLabel.bottom+10, width: collectionSize, height: collectionSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with: String) {
        
    }
}

extension ExampleTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.identifier, for: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        return cell
    }
    
    
}
