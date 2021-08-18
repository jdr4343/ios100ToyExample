//
//  TileCollectionViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {
    static let identifier = "TileCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
    }
    //보통 위의 이니셜라이저를 생성해주고 fix를 누르면 이코드가 생성 됩니다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
