//
//  CustomTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    private let _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = .lightGray
        _switch.isOn = true
        return _switch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(_switch)
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _switch.frame = CGRect(x: 20, y: contentView.height / 2,
                               width: contentView.width,
                               height: contentView.height - 20)
    }
    
    
    
    
}
