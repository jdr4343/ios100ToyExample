//
//  Model.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import Foundation
import UIKit

struct CollectionTableViewCellViewModel {
    let viewModels: [TileCollectionViewCellViewModel]
}

struct TileCollectionViewCellViewModel {
    let name: String
    let backgroundColor: UIColor
}

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTabItem(with viewModel: TileCollectionViewCellViewModel)
}
