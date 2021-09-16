//
//  CheckBox.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

final class CircleCheckBox: UIView {

    private var isChecked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        
        layer.cornerRadius = width / 2.0
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func toggle() {
        self.isChecked = !isChecked
        if self.isChecked {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBackground
        }
    }
    
    //테마가 바뀔때마다 테두리의 색상을 변환하기 위해서 추가하는 함수
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.label.cgColor
    }
    
}
