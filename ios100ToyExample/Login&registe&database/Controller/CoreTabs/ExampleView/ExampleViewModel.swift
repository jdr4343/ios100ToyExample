//
//  ExampleViewModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import Foundation
import UIKit

struct ExampleTableViewCellModel {
    let title: String
    let viewModels: [ExampleCollectionViewModel]
}

struct ExampleCollectionViewModel {
    let name: String
    let backgroundImage: String
    let handler: () -> Void
}

protocol ExampleCollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTabItem(with viewModel: ExampleCollectionViewModel)
}
