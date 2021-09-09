//
//  LineViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit
import Charts

class LineViewController: UIViewController, ChartViewDelegate {
    
    
    //차트생성
    let lineChart = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "라인"
        lineChart.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0,
                                 width: view.frame.size.width,
                                 height: view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        
        
    
    
    //차트에 대한 일부 데이터 설정
    var entries = [ChartDataEntry]()
    for x in 0..<10 {
        entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
    }
    //위에서 만든 entries를 set에 저장하고 프레임워크에서 지원하는 템플릿 사용
    let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
    //set을 data로 저장 한후 값 전달
    let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        
        // 뷰전환
        nextButton()
    }
    private func nextButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .done, target: self, action: #selector(nextViewButton))
    }
    @objc private func nextViewButton() {
        let VC = PieViewController()
        navigationController?.pushViewController(VC, animated: true)
    }


}
