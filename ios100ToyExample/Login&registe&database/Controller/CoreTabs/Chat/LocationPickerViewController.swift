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
    private var isPickable = true
    //지도 생성
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    //좌표를 초기화
    init(coordinates: CLLocationCoordinate2D?) {
        self.coordinates = coordinates
        self.isPickable = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //보내는 사람에게만 제스처를 연결하고 전송 버튼을 보여주겠습니다. 위치 경로를 클릭해서 들어오는 사람은 이 버튼을 보지 못합니다.
        if isPickable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "전송", style: .done
                                                                , target: self, action: #selector(didTapSendButton))
            //맵을 클릭 했을때 액션을 추가하기 위해 제스쳐를 연결 합니다.
            map.isUserInteractionEnabled = true//제스쳐 상호 작용 활성화
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMap))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            map.addGestureRecognizer(gesture)
        } else {
            //받는 사람이라면 위치를 선택할수 없으므로 그저 보기만 가능합니다.
            guard let coordinates = self.coordinates else  {
                return
            }
            //지도가 더 가깝게 보이도록 합니다.
            //map.setRegion(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>, animated: <#T##Bool#>)
            //지도의 위치를 핀으로 고정하여 사용자가 탭한 위치를 시각적으로 볼수 있도록 합니다.
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            map.addAnnotation(pin)
         
        }
        
        view.backgroundColor = .systemBackground
        view.addSubview(map)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    @objc func didTapSendButton() {
        guard let coordinates = coordinates else {
            return
        }
        navigationController?.popViewController(animated: true)
        completion?(coordinates)
    }

    @objc func didTapMap(_ gesture: UITapGestureRecognizer) {
        let locationInView = gesture.location(in: map)
        //좌표 / 위치 변환
        let coordinates = map.convert(locationInView, toCoordinateFrom: map)
        self.coordinates = coordinates
        
        //새로운 지역을 핀으로 고정하면 기존의 고정되어 있는 핀을 지우겠습니다.
        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
        
        //지도의 위치를 핀으로 고정하여 사용자가 탭한 위치를 시각적으로 볼수 있도록 합니다.
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
       
        
    }
}
