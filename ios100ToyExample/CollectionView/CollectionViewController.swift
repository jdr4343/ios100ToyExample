//
//  CollectionViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   

    //컬렉션 뷰 생성
    private let collectionView = UICollectionView(
        frame: .zero,
        //FlowLayout을 쓰면 셀을 원하는 형태로 정렬할수 있습니다.이는 객체가 셀을 경로에 배치하고 최대한 행을 따라 많은 셀을 채우는 것을 의미합니다.현재의 행에 더이상 셀이 들어갈 수 없게 된다면 새로운 행을 만들어서 레이아웃 프로세스를 진행하게 됩니다!
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    // MARK: - UICollectionViewDelegate,UICollectionViewDataSource
    
    //컬렉션 뷰 섹션의 항목의 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                      for: indexPath)
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    //항목의 크기 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.width/3)-3,
            height: (view.width/3)-3
        )
    }
    
    //스페이싱
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    //탭 기능
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("\(indexPath.row+1)째를 선택하셨습니다.")
    }
}
