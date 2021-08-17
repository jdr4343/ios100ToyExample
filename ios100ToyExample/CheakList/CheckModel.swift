//
//  CheakModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import Foundation
//모델을 생성합니다. 보통 이런식으로 모델들을 한 파일에 모아 둡니다. 그러나 편의를 위해서 같은 뷰 안에서 만들어도 됩니다. 저도 버릇을 만들기 위한 파일이며 편의를 위해서 뷰 컨트롤러에서 만들어도 하등 차이 없습니다.
class CheckListItem {
    let title: String
    var isChecked: Bool = false
    //이니셜라이저를 추가해줍니다. 체크리스트는 디폴트값이 주어져 있기때문에 따로 추가하지 않아도 됩니다.
    init(title: String) {
        self.title = title
    }
}
