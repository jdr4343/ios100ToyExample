//
//  MapViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchResultsUpdating {
 

    //지도를 만듭니다.
    let mapView = MKMapView()
    
    //검색 컨트롤러를 만듭니다.
    let searchVC = UISearchController(searchResultsController: SearchResultViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "지도앱"
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        //검색 표시줄을 추가합니다.
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        searchVC.searchBar.backgroundColor = .systemBackground

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //지도가 검색표시줄을 가리지 않도록 프레임을 정해줍니다.
        mapView.frame = CGRect(x: 0,
                               y: view.safeAreaInsets.top,
                               width: view.width,
                               height: view.height-view.safeAreaInsets.top)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    


}
