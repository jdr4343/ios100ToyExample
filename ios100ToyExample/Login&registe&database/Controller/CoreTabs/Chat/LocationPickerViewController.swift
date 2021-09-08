//
//  LocationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/08.
//

import UIKit
import CoreLocation
import MapKit

class LocationPickerViewController: UIViewController {

    public var completion: ((CLLocationCoordinate2D) -> Void)?
    private var coordinates: CLLocationCoordinate2D?
    //지도 생성
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "위치"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "전송", style: .done
                                                            , target: self, action: #selector(didTapSendButton))
        view.addSubview(map)
        
        //맵을 클릭 했을때 액션을 추가하기 위해 제스쳐를 연결 합니다.
        map.isUserInteractionEnabled = true// 상호 작용 활성화
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMap))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        map.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    @objc func didTapSendButton() {
        guard let coordinates = coordinates else {
            return
        }
        completion?(coordinates)
    }

    @objc func didTapMap(_ gesture: UITapGestureRecognizer) {
        let locationInView = gesture.location(in: map)
        //좌표 / 위치 변환
        let coordinates = map.convert(locationInView, toCoordinateFrom: map)
        self.coordinates = coordinates
        
        //지도의 위치를 핀으로 고정하여 사용자가 탭한 위치를 시각적으로 볼수 있도록 합니다.
        let pin = MKPointAnnotation()
        pin.coordinate = self.coordinates
        map.addAnnotation(pin)
    }
}
