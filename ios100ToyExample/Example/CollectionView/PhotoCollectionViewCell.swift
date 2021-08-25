//
//  CollectionViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    //이런한 셀종류들은 그냥 시작할때 바로 그냥 식별자를 설정한다고 보면 되는거 같습니다.
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        //이미지 할당 / 이렇게 이미지를 한꺼번에 할당하면 하나씩 만들 필요가 없습니다!
        let images = [
            UIImage(named: "맥스달튼1"),
            UIImage(named: "맥스달튼2"),
            UIImage(named: "맥스달튼3"),
            UIImage(named: "맥스달튼4"),
            UIImage(named: "맥스달튼5"),
            UIImage(named: "맥스달튼6"),
            UIImage(named: "맥스달튼7"),
            UIImage(named: "맥스달튼8"),
            UIImage(named: "맥스달튼9"),
            UIImage(named: "맥스달튼10"),
            UIImage(named: "맥스달튼11"),
            UIImage(named: "맥스달튼12"),
            UIImage(named: "맥스달튼13"),
            UIImage(named: "맥스달튼14"),
            UIImage(named: "맥스달튼15"),
            UIImage(named: "맥스달튼16")
        ].compactMap({ $0 })
        imageView.image = images.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    //이 함수는 셀을 재사용 하기 전에 호출되어 재설정을 수행합니다!
    //셀을 재사용할때 인터넷 연결이 최상이 아니거나 빠르게 스크롤 될때 일부 이미지가 없어야 할 위치에 있을을 알아차릴수 있습니다. 이는 우리가 셀을 재사용하기 때문에 텍스트와 이미지가 롤 오버되어 잘못된셀에 잘못된 이미지가 표시됩니다. 이를 방지하기 위해 사용합니다.
    override func prepareForReuse() {
        super.prepareForReuse()
      //  imageView.image = nil
    }
    
}
