//
//  EditTextViewTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/31.
//


import UIKit

//리턴키를 누르면 컨트롤러가 값을 반환하기를 원하므로 protocol을 선언하겠습니다. 업데이트할 모델을 연결하여 리턴키를 누르면 값을 전달하도록 구현할 것입니다.
protocol EditTextViewTableViewCellDelegate: AnyObject {
    func formTextViewTableViewCell(_ cell: EditTextViewTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

//프로필 변경 셀입니다.
class EditTextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    static let identifier = "EditTextViewTableViewCell"

    //생성한 프로토콜을 연결합니다.
    public weak var delegate: EditTextViewTableViewCellDelegate?
    
    //모델 연결
    private var model: EditProfileFormModel?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()
    
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.returnKeyType = .done
        textView.font = .boldSystemFont(ofSize: 14)
        return textView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(textView)
        textView.delegate = self
        //셀이 선택되지 않도록 속성을 하나 추가 하겠습니다.
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10,
                                 y: 0,
                                 width: contentView.width/2,
                                 height:contentView.height/6 )
        textView.frame = CGRect(x: 10, y: nameLabel.bottom, width: contentView.width-20, height: contentView.height-20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        textView.text = nil
        
    }
    
    //프로필을 편집하는 양식이 될것입니다. formLabel 에서 작성하는 텍스트는 프로필화면의 모델의 라벨이 되고 이런식으로! 🤪 휴먼 에러에 골머리 싸고 고민 했더니 머리가 깨질것 같네요 ㅜㅜ
    public func configuer(with model: EditProfileFormModel) {
        self.model = model
        nameLabel.text = model.label
        textView.insertTextPlaceholder(with: CGSize(width: contentView.width, height: 50))
        textView.text = model.value
    }
    
    
    
    //MARK: textView
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        model?.value = textView.text
        guard let model = model else {
            return true
        }
        delegate?.formTextViewTableViewCell(self, didUpdateField: model)
        textView.resignFirstResponder()
        return true
    }
    
    

    
    
}
