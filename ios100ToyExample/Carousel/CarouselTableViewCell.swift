//
//  CarouselTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    //셀을 직접 만들어 보겠습니다 / 우선은 셀에 식별자를 추가 하겠습니다. /static 키워드를 사용하는 이유는 자주 변하지 않는 일정한 값이나 설정 정보를 매번 메모리를 로딩하지 않기 위해서 입니다. 지금 같이 앱이 작은 경우에는 쓰나 안쓰나 별차이가 없는것 같지만 버릇을 들여노면 좋겠죠?
    static let identifier = "CarouselTableViewCell"

    //fileprivate와 비슷한 private입니다 fileprivate는 해당 클래스가 정의된 소스 코드에서는 프토퍼티에 접근할수 있지만 private는 선언한 변수나 상수를 포함하는 클래스나 익스텐션에서만 접근이 가능합니다.
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //뷰를 수평으로 지정
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TileCollectionViewCell.self,
                                forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    
    
    //재사용 가능한 셀
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
    }
    
    
    
    
}
//MARK: - CollectionView
//확장자를 사용하여 델리게이트와 데이터 소스를 연결하겠습니다!
extension CarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TileCollectionViewCell.identifier,
            for: indexPath) as?  TileCollectionViewCell else {
                fatalError()
            }
        return cell
    }
    
    
}
