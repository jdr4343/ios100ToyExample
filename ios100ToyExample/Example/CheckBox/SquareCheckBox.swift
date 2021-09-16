//
//  SquareCheckBox.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

enum CheckBoxState {
    case checked
    case unchecked
    case disabled
}

class SquareCheckBox: UIView {

    var isChecked = false
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.tintColor = .systemRed
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    private let boxView: UIView = {
        let boxView = UIView()
        boxView.layer.borderWidth = 0.5
        boxView.layer.borderColor = UIColor.label.cgColor
        return boxView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(boxView)asfdasfas
        addSubview(imageView)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.frame = bounds
        imageView .frame = CGRect(x: 0, y: -10, width: frame.width, height: frame.width)
    }
    
    public func toggle() {
        self.isChecked = !isChecked
        imageView.isHidden = !isChecked
    }

}
