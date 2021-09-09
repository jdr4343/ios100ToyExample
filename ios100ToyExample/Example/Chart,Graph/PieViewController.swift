//
//  PieViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit
import Charts

class PieViewController: UIViewController, ChartViewDelegate {

    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "원"
        pieChart.delegate = self
        view.backgroundColor = .white

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        pieChart.frame = CGRect(x: 0, y: 0,
                                 width: view.frame.size.width,
                                 height: view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        
    
    
    //차트에 대한 일부 데이터 설정
    var entries = [ChartDataEntry]()
    for x in 0..<10 {
        entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
    }
    //위에서 만든 entries를 set에 저장하고 프레임워크에서 지원하는 템플릿 사용
    let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
    //set을 data로 저장 한후 값 전달
    let data = PieChartData(dataSet: set)
        
        pieChart.data = data
    
    }
    


}
