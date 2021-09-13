//
//  FirstTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/13.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    static let identifier = "FirstTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
