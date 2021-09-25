//
//  imageInfoView.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

protocol ImageInfoViewDataSource: AnyObject {
    func imageInfoViewTitleForImage(_ imageView: ImageInfoView) -> String?
    func imageInfoViewURLForImage(_ imageView: ImageInfoView) -> URL?
}

class ImageInfoView: UIView {

    public weak var datasource: ImageInfoViewDataSource?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.text = "무야호"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-250)/2, y: 0, width: 250, height: 250)
        titleLabel.frame = CGRect(x: 0  , y: 260, width: width, height: 70)
        
    }
    
    private func configure() {
        guard let dataSource = datasource else {
            return
        }
        titleLabel.text = datasource?.imageInfoViewTitleForImage(self)
        guard let imageUrl = dataSource.imageInfoViewURLForImage(self) else {
            return
        }
        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    public func reloadData() {
        configure()
    }
    
}
