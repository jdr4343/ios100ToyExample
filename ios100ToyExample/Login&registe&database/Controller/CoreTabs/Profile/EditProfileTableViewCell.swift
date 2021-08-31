//
//  EditProfileTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import UIKit

//리턴키를 누르면 컨트롤러가 값을 반환하기를 원하므로 protocol을 선언하겠습니다. 업데이트할 모델을 연결하여 리턴키를 누르면 값을 전달하도록 구현할 것입니다.
protocol EditProfileTableViewCellDelegate: AnyObject {
    func formTextFieldTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

//프로필 변경 셀입니다.
class EditProfileTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "EditProfileTableViewCell"

    //생성한 프로토콜을 연결합니다.
    public weak var delegate: EditProfileTableViewCellDelegate?
    
    //모델 연결
    private var model: EditProfileFormModel?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()
    
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.font = .boldSystemFont(ofSize: 14)

        return field
    }()
    
    
  
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(field)
        field.delegate = self
        //셀이 선택되지 않도록 속성을 하나 추가 하겠습니다.
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10,
                                 y: 10,
                                 width: contentView.width/2,
                                 height:contentView.height/5 )
        field.frame = CGRect(x: 10, y: nameLabel.bottom, width: contentView.width, height: contentView.height/2)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    //프로필을 편집하는 양식이 될것입니다. formLabel 에서 작성하는 텍스트는 프로필화면의 모델의 라벨이 되고 이런식으로! 🤪 휴먼 에러에 골머리 싸고 고민 했더니 머리가 깨질것 같네요 ㅜㅜ
    public func configuer(with model: EditProfileFormModel) {
        self.model = model
        nameLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    //MARK: - TextField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //사용자가 필드에서 리턴 키를 누를때마다 그들이 편집하고 있다는걸 델리게이트에게 알립니다.우리는 위의 configure와 동일한 방식으로 생각하면 좀더 이해하기 쉽습니다.
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTextFieldTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
    
    
}



