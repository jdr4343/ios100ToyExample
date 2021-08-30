//
//  EditProfileTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit

//리턴키를 누르면 컨트롤러가 값을 반환하기를 원하므로 protocol을 선언하겠습니다. 업데이트할 모델을 연결하여 리턴키를 누르면 값을 전달하도록 구현할 것입니다.
protocol EditProfileTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField updateModel: UserModel)
}

//프로필 변경 셀입니다.
class EditProfileTableViewCell: UITableViewCell {

    static let identifier = "EditProfileTableViewCell"

    //생성한 프로토콜을 연결합니다.
    public weak var delegate: EditProfileTableViewCellDelegate?
    
    //모델 연결
    private var model: UserModel?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 8
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.returnKeyType = .done
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(field)
        contentView.addSubview(textView)
        field.delegate = self
        textView.delegate = self
        //셀이 선택되지 않도록 속성을 하나 추가 하겠습니다.
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configuer() {
        
    }
}

extension EditProfileTableViewCell: UITextFieldDelegate,UITextViewDelegate {
    
}
