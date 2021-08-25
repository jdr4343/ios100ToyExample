//
//  SectionITableViewHeaderFooterView.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

//MARK: - Header


class SectionTableHeader: UITableViewHeaderFooterView {
    static let identifier = "SectionTableHeader"
    
    //헤더(머릿글)에 이미지를 추가하겠습니다.
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "girl")
        return imageView
    }()
    //이어서 라벨을 추가하겠습니다.
    private let label: UILabel = {
        let label = UILabel()
        label.text = "집시님의 작품입니다!"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(text: String) {
//        label.text = text
//    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //이미지가 있기 때문에 라벨의 크기를 맞추겠습니다.
        label.sizeToFit()
        label.frame = CGRect(x: 0,
                             y: contentView.height-10-label.height,
                             width: contentView.width,
                             height: label.height)
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: contentView.width,
                                 height: contentView.height-15-label.height)
    }
}

//MARK: - Footer

class SectionTableFooter: UITableViewHeaderFooterView {
    static let identifier = "SectionTableFooter"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "나중에 돈을 많이벌면"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private let sublabel: UILabel = {
        let label = UILabel()
        label.text = "콜라보 한번 해보고 싶군요.."
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(sublabel)
        contentView.backgroundColor = .systemTeal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        sublabel.sizeToFit()
        
        label.frame = CGRect(
            x: 0, y: 0,
            width: contentView.width, height: contentView.height/2
        )
        sublabel.frame = CGRect(
            x: 0, y: contentView.height/2,
            width: contentView.width, height: contentView.height/2
        )
    }
}
