//
//  SegmentedViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/23.
//

import UIKit

class SegmentedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["fruits","fasteFood","third"])
        control.tintColor = .systemIndigo
        control.selectedSegmentTintColor = .systemIndigo
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didSelectedControl), for: .valueChanged)
        return control
    }()
    
    private let tableView = UITableView(frame: .zero, style:  .plain)
    
    private let fruits = ["Apple","Mango","Orange"]
    private let fasteFood = ["Hamberger","Pizza","Chicken"]
    private let koreanFood = ["dduckboki","GGomakMuchim", "KimChiJJige"]
    
    private lazy var foodArray = fruits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        
        //세그먼트 간격 추가
        let paddingStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddingStackView.layoutMargins = .init(top: 12, left: 12, bottom: 10, right: 12)
        paddingStackView.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [paddingStackView,tableView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    @objc private func didSelectedControl() {
        print(segmentedControl.selectedSegmentIndex)
    
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            foodArray = fruits
        case 1:
            foodArray = fasteFood
        case 2:
            foodArray = koreanFood
        default:
            break
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = foodArray[indexPath.row]
        return cell
    }


}
