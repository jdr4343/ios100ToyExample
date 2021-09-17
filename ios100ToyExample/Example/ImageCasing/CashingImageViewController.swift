//
//  CashingImageViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

class CashingImageViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.dataSource = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    


}
extension CashingImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        //cell.title = "Cell \(indexPath.row)"
        cell.image = UIImage(named: "food1")
        return cell
    }
    
    
}
