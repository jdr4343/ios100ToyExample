//
//  SectionViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit



class SectionViewController: UIViewController {

    //언제나 처럼 테이블을 생성하고 셀을 등록합니다! 🤗 작업 공간을 넓게 가지고 싶다면 cmd + 0, cmd + optiion + 0,cmd + shift + y를 눌러보세요!
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //SectionViewController에서 만들었던 헤더와 푸터를 등록합니다.
        table.register(SectionTableHeader.self, forHeaderFooterViewReuseIdentifier: SectionTableHeader.identifier)
        table.register(SectionTableFooter.self, forHeaderFooterViewReuseIdentifier: SectionTableFooter.identifier)
        return table
    }()
    
    private let models = [
        "여기 있는 modles 배열은",
        "테이블 뷰 셀들의 항목이 될것입니다.",
        "아래에 model.count를",
        "썼으니 이모델의 수만큼 반환되어",
        "🖐개의 항목이 생기게 될것입니다!",
        "여기서 더적으면 더 늘어나겠죠?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}
extension SectionViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: = middle

    func numberOfSections(in tableView: UITableView) -> Int {
        //섹션의 수를 반환합니다. 
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //여기서는 셀안의 텍스트를 설정해줍니다. 모델의 항목들이 색인 순서대로 표시 되겠군요!
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    //MARK: - header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionTableHeader.identifier)
        return header
    }
    //헤더 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
    
    
    //MARK: - footer
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionTableFooter.identifier)
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
}
