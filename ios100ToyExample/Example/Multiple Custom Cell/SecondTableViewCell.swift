//
//  SecondTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/13.
//

import UIKit
//awakeFromNib을 체크 해주시고 파일을 만들어주세요.
class SecondTableViewCell: UITableViewCell {

    static let identifier = "SecondTableViewCell"
    
    @IBOutlet var myImageView: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "SecondTableViewCell", bundle: nil)
    }
    
    public func configure(with imageName: String) {
        ///viewController에서 호출하여 이미지를 불러오는 역활을 하게되는 함수입니다.
        myImageView.image = UIImage(named: imageName)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
