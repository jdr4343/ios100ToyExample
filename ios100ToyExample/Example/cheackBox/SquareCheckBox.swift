//
//  SquareCheckBox.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class SquareCheckBox: UIView {
  //  var models = [TodoListItem]()
    var isChecked = true
  
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public var checkImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "checkmark")
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .white //휜색이라 안보일수 있으니 바꿔주세요! 홈뷰에서 재사용중이라..!
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
        //아 .. 생각 해보니 여기에 불리언 값만 전한다고 코어 데이터에 저장이 되는게 아니라 이미지를 같이 저장해줘야되는구나.. 구현대기
       self.isChecked = !isChecked
//        let Checked = TodoListItem(context: context)
//        Checked.isChecked = isChecked
//        print(Checked.isChecked)
        checkImage.isHidden = isChecked
   }

}
