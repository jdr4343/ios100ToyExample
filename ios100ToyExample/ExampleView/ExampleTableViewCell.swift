//
//  ExampleTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

    static let identifier = "ExampleTableViewCell"
    
    private var viewModels: [ExampleCollectionViewModel] = []
    
    weak var delegate: ExampleCollectionTableViewCellDelegate?
    
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
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
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
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 20, y: 10, width: contentView.width-20, height: contentView.height/6)
        collectionView.frame = CGRect(x: 10, y: titleLabel.bottom+10, width: contentView.width - 10, height: contentView.height-titleLabel.height)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
   
}

extension ExampleTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.identifier, for: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func configure(with viewModel: ExampleTableViewCellModel) {
        //구현이 안된다면 찾아올것
        self.titleLabel.text = viewModel.title
        self.viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.width/1.8
        return CGSize(width: width, height: width/1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        delegate?.collectionTableViewCellDidTabItem(with: viewModel)
    }
}
