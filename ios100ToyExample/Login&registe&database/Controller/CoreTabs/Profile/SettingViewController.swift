//
//  SettingViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

//설정 화면을 만듭니다. 프로필 화면 상단 네비게이션 바에서 버튼을 만들것 입니다.

//MARK: - 모델
struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}


import UIKit

final class SettingViewController: UIViewController {
    
    //먼저 일반적인 테이블 뷰를 만들겠습니다!
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        return table
    }()
    
    //모델을 2차원 배열로 연결합니다 2차원 배열인 이유는 여러개의 섹션이 존재 할것이기 때문입니다! 🥶
    //배열안의 배열이라고 생각하면 좀더 이해하시기 수월 할거 같습니다..! [[1,1,1,1],[1,1,1,1],[1,1,1,1] 이런식으로 배열안에 배열이 있는 거죠!
    //configureModels 함수를 예시를 들어서 보면 우리가 만든 모델을 [[section],[secction]] 이런식으로 나누어 주고 있습니다.section에는 우리가 만든 모델의 요소가 들어있습니다.
    //만약 [[title,hendler],[title,hendler]] 이런식으로 2차원 배열을 만들어주면 우리는 이제 4개의 요소와 2개의 섹션이 있습니다. 아래의 테이블 뷰 델리게이트에서는 요소.count를 해서 행의 수를 반환하고 섹션.count를 해서 섹션의 수를 반환 하고 있습니다.그럼 2개의 섹션과 4개의 셀을 얻을수 있겠죠?
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //SettingCellModel을 섹션 배열에 요소를 추가하고 나눠 줍니다.
    private func configureModels() {
        let section = [
            SettingCellModel(title: "로그아웃", handler: { [weak self] in
                self?.didTabLogOut()
            })
        ]
        data.append(section)
    }
    //로그아웃 기능을 구현합니다. / 이때 경고창도 만들어 실제로 로그아웃 할건지 물어보겠습니다.
    private func didTabLogOut() {
        let actionSheet = UIAlertController(
            title: "로그아웃",
            message: "로그아웃 하시겠습니까?",
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        //destructive는 사용자 데이터를 삭제하거나 앱을 취소 할수 없게 변경하는 작업에 이 옵션을 사용합니다.이옵션을 쓰면 강조 표현이 들어갑니다!!이게 중요한 점이쥬!!굳이 색깔을 안넣어도 된다니! 🤩
        actionSheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
            //로그아웃 기능 구현
            AuthManager.shared.logOut { success in
                if success {
                    //로그인 화면 호출
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        //로그아웃 하고 다시 프로필 부터 뜨지 않게 하기 위해서 현재 설정화면과 모든 스택을 사라지게 하고 rootViewController로 돌아갑니다.그러한 후 탭바중 0번째 인덱스로 이동합니다.
                        self.navigationController?.popToRootViewController(animated: true)
                        self.tabBarController?.selectedIndex = 0
                    }
                } else {
                    fatalError("로그아웃 할수 없습니다..")
                }
            }
        }))
        //아이패드로 켰을때 충돌하지 않게 하기위해서 PresentationController 위에 팝을 할당하겠습니다.
        //아이패드에서 이 두 코드를 할당해주지 않으면 액션 시트가 스스로를 표시하는 방법을 알지 못해 크래쉬가 발생하게 됩니다.
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true)
    }

}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.identifier, for: indexPath) as! EditProfileTableViewCell
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //셀 선택 처리/ 섹션의 행의 순서대로 위치한 핸들러가 작동합니다.
        let model = data[indexPath.section][indexPath.row].handler()
    }
    
}
