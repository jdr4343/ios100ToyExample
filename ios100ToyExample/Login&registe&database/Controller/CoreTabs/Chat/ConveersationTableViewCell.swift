//
//  ConveersationTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/03.
//

import UIKit

class ConveersationTableViewCell: UITableViewCell {

  static let identifire = "ConveersationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure(with model: String) {
        
    }
}
