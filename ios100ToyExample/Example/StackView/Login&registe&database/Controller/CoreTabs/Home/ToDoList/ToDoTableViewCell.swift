//
//  ToDoTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/17.
//

import UIKit



class ToDoTableViewCell: UITableViewCell {

   static let identifier = "ToDoTableViewCell"
    
    let checkBox = SquareCheckBox()
    
   
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "오늘의 할일은"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(checkBox)
        checkBox.layer.borderWidth = 1
        checkBox.layer.borderColor = UIColor.white.cgColor
        contentView.addSubview(label)
        let geseture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        checkBox.addGestureRecognizer(geseture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkBox.frame = CGRect(x: 20, y: height/2, width: 15, height: 15)
        label.frame = CGRect(x: checkBox.right+10, y: height/2-10, width: width-30, height: height)
    }
    
    @objc func didTapCheckBox() {
        print("체크박스가 클릭 되었습니다.")
        checkBox.toggle()
        
        
    }
    
}
