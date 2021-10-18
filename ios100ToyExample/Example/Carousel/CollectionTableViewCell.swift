//
//  CarouselTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    //셀을 직접 만들어 보겠습니다 / 우선은 셀에 식별자를 추가 하겠습니다. /static 키워드를 사용하는 이유는 자주 변하지 않는 일정한 값이나 설정 정보를 매번 메모리를 로딩하지 않기 위해서 입니다. 지금 같이 앱이 작은 경우에는 쓰나 안쓰나 별차이가 없는것 같지만 버릇을 들여노면 좋겠죠?
    static let identifier = "CarouselTableViewCell"
    
    //모델의 프로토콜과 연결
    weak var delegate: CollectionTableViewCellDelegate?
    
    //모델을 빈 배열로 선언 해주고 아래의 테이블 뷰에서 연결하도록 하겠습니다.
    private var viewModels: [TileCollectionViewCellViewModel] = []
    
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
extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TileCollectionViewCell.identifier,
                for: indexPath) as?  TileCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func configure(with viewModel: CollectionTableViewCellViewModel) {
       viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
    
    //컬렉션의 사이즈 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width/2.5
        return CGSize(width: width, height: width/1.1 )
    }
    
    //탭액션 / 테이블뷰에서 이코드를 불렀을 경우 셀이 선택될것이고 콜렉션 뷰에서 부른다면 셀안의 컬렉션이 선택 될 것입니다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        delegate?.collectionTableViewCellDidTabItem(with: viewModel)
    }
}
