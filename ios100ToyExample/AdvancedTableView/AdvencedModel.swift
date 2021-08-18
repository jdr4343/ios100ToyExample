//
//  AdvencedModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import Foundation

//cell 모델 /셀의 유형을 파악하기 위해 뷰 컨트롤러의 테이블 뷰에서 사용할 것입니다. 두가지 case를 가질것입니다. / 여기에서 행은 컬렉션 뷰에서 얼마나 많은 행을 표시할지 결정합니다.
enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}
//유형을 지정하겠습니다.
struct ListCellModel {
    let title: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}

