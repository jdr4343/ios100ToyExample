//
//  SquareCheckBox.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class SquareCheckBox: UIView {
    
    var isChecked = true

    private var checkImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "checkmark")
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .white
        imageview.isHidden = true
        return imageview
    }()
    
    private let checkBox: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkBox)
        addSubview(checkImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkBox.frame = bounds
        checkImage.frame = CGRect(x: 0, y: -10, width: frame.width, height: frame.width)
    }
    
    func toggle() {
       self.isChecked = !isChecked
        checkImage.isHidden = isChecked
   }

}
