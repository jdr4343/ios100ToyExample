//
//  ExampleViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/10.
//

import UIKit
import Floaty

class ExampleViewController: UIViewController {
    
    
    private var viewModels = [[ExampleTableViewCellModel]]()
    
    var models = [TodoListItem]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        return tableView
    }()
    
    private let floating: Floaty = {
        let button = Floaty()
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.buttonColor = UIColor.white
        button.buttonImage = UIImage(systemName: "books.vertical.fill")
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "예제"
        configureModels()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(floating)
        setFloatingButton()
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        floating.frame = CGRect(x: view.frame.width-60-16, y: view.frame.height-60-16-view.safeAreaInsets.bottom, width: 60, height: 60)
    }
    
    //플로팅 버튼 구현
    private func setFloatingButton() {
        floating.addItem("늘어나고 줄어드는 신축성 테이블 뷰 헤더", icon: UIImage(systemName:
            "rectangle.topthird.inset")!, handler: { item in
                let stratchyVC = StretchyViewController()
                self.navigationController?.pushViewController(stratchyVC, animated: true)
        })
        floating.addItem("테이블뷰 헤더와 푸터!", icon: UIImage(systemName:
            "lineweight")!, handler: { item in
            let  SectionVC = SectionViewController()
                self.present(SectionVC, animated: true)
        })
        floating.addItem("수평 슬라이드 컬렉션 테이블뷰", icon: UIImage(systemName: "slider.horizontal.below.square.fill.and.square")!, handler: { item in
            //핸들러를 열고 기능 구현을 하면 됩니다.
            let CarouselVC = CarouselViewController()
            self.navigationController?.pushViewController(CarouselVC, animated: true)
        })
        floating.addItem("동영상,수평,수직 컬렉션 테이블뷰", icon: UIImage(systemName: "square.grid.3x1.fill.below.line.grid.1x2")!, handler: { item in
            let AdvancedVC = AdvancedViewController()
            self.present(AdvancedVC, animated: true, completion: nil)
        })
        self.view.addSubview(floating)
        floating.addItem("캐시 이미지", icon: UIImage(systemName: "rectangle.fill.badge.plus")!, handler: { item in
            let vc = CashingImageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }

    
    
    private func configureModels() {
        //첫번쨰 섹션
        viewModels.append([ExampleTableViewCellModel(title: "재미있는 예제", viewModels:
          [ExampleCollectionViewModel(name: "그라데이션",
                                      backgroundImage: "그라데이션", handler: { [weak self] in
                                        self?.didTabGradientButton()
                                      }),
           ExampleCollectionViewModel(name: "색상선택기",
                                      backgroundImage: "색상선택기", handler: { [weak self] in
                                        self?.didTabColorWellButton()
                                      }),
           ExampleCollectionViewModel(name: "폰트선택기",
                                      backgroundImage: "폰트선택기", handler: { [weak self] in
                                        self?.didTabFontPickerButton()
                                      }),
           ExampleCollectionViewModel(name: "날짜선택기",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTapDatePickerButton()
                                      }),
           ExampleCollectionViewModel(name: "PDF 삽입",
                                      backgroundImage: "PDF", handler: { [weak self] in
                                        self?.didTabPDFButton()
                                      }),
           ExampleCollectionViewModel(name: "웹뷰",
                                      backgroundImage: "웹뷰", handler: { [weak self] in
                                        self?.didTabWebButton()
                                      }),
           ExampleCollectionViewModel(name: "타이머",
                                      backgroundImage: "타이머", handler: { [weak self] in
                                        self?.didTabTimerButton()
                                      }),
           ExampleCollectionViewModel(name: "프로그래스 바",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTabProgressBarButton()
                                      }),
           ExampleCollectionViewModel(name: "세그먼트 컨트롤",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTabSegmentedButton()
                                      }),
           ExampleCollectionViewModel(name: "커스텀 액션시트",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTapBottomCard()
                                      })
          ])])
        
        

        viewModels.append([ExampleTableViewCellModel(title: "기본 예제", viewModels:
          [ExampleCollectionViewModel(name: "바버튼",
                                      backgroundImage: "바버튼", handler: { [weak self] in
                                        self?.didTabBarButtonItem()
                                      }),
           ExampleCollectionViewModel(name: "텍스트경고창",
                                      backgroundImage: "텍스트경고창", handler: { [weak self] in
                                        self?.didTabTextFieldAlertButton()
                                      }),
           ExampleCollectionViewModel(name: "날짜생성",
                                      backgroundImage: "날짜생성", handler: { [weak self] in
                                        self?.didTabDateFormatterButton()
                                      }),
           ExampleCollectionViewModel(name: "키보드툴바",
                                      backgroundImage: "키보드툴바", handler: { [weak self] in
                                        self?.didTabKeyboardBarButton()
                                      }),
           ExampleCollectionViewModel(name: "오디오재생",
                                      backgroundImage: "오디오재생", handler: { [weak self] in
                                        self?.didTabAudioButton()
                                      }),
           ExampleCollectionViewModel(name: "Timer()응용",
                                      backgroundImage: "타이머응용", handler: { [weak self] in
                                        self?.didTabUsingTimerButton()
                                      }),
           ExampleCollectionViewModel(name: "사진",
                                      backgroundImage: "사진찍기", handler: { [weak self] in
                                        self?.didTabCameraButton()
                                      }),
           ExampleCollectionViewModel(name: "체크박스",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTabCheckBoxButton()
                                      })
          ])])
        
        
        
        viewModels.append([ExampleTableViewCellModel(title: "기본 뷰 다루기", viewModels:
          [ExampleCollectionViewModel(name: "테이블뷰",
                                      backgroundImage: "테이블뷰", handler: { [weak self] in
                                        self?.didTabTableViewButton()
                                      }),
           ExampleCollectionViewModel(name: "컬렉션뷰",
                                      backgroundImage: "컬렉션뷰", handler: { [weak self] in
                                        self?.didTabCollectionViewButton()
                                      }),
           ExampleCollectionViewModel(name: "오토레이아웃",
                                      backgroundImage: "오토레이아웃", handler: { [weak self] in
                                        self?.didTabAutoButton()
                                      }),
           ExampleCollectionViewModel(name: "스택뷰",
                                      backgroundImage: "스택뷰", handler: { [weak self] in
                                        self?.didTabStackButton()
                                      }),
           ExampleCollectionViewModel(name: "페이징컨트롤",
                                      backgroundImage: "페이징컨트롤", handler: { [weak self] in
                                        self?.didTabPageControlButton()
                                      }),
           ExampleCollectionViewModel(name: "체크리스트",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTabCheckButton()
                                      }),
           
           
          
          ])])
        
        viewModels.append([ExampleTableViewCellModel(title: "뷰 다루기 심화", viewModels:
         [ExampleCollectionViewModel(name: "노티피케이션 센터",
                                     backgroundImage: "", handler: { [weak self] in
                                            self?.didTapNotificationButton()
                                        }),
          
          
        ])])
        
        viewModels.append([ExampleTableViewCellModel(title: "커스텀", viewModels:
          [ExampleCollectionViewModel(name: "커스텀 프로그래스 써클",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTapCustomProgressCircle()
                                    }),
           ExampleCollectionViewModel(name: "커스텀탭바",
                                      backgroundImage: "커스텀탭바", handler: { [weak self] in
                                        self?.didTabCustomTabBarButton()
                                      }),
           ExampleCollectionViewModel(name: "커스텀셀",
                                      backgroundImage: "커스텀셀", handler: { [weak self] in
                                        self?.didTabCustomcellsButton()
                                      }),
           ExampleCollectionViewModel(name: "멀티플 커스텀 셀",
                                      backgroundImage: "커스텀탭바", handler: { [weak self] in
                                        self?.didTaMultipleButton()
                                      }),
           ExampleCollectionViewModel(name: "커스텀 프로그래스 바",
                                      backgroundImage: "커스텀탭바", handler: { [weak self] in
                                        self?.didTapCustomProgressBar()
                                      }),
          
          
          ])])
        
        
        viewModels.append([ExampleTableViewCellModel(title: "프레임 워크", viewModels:
          [ExampleCollectionViewModel(name: "애니메이션탭바",
                                      backgroundImage: "애니메이션탭바", handler: { [weak self] in
                                        self?.didTabAnimatedButton()
                                      }),
           ExampleCollectionViewModel(name: "차트/그래프",
                                      backgroundImage: "그래프", handler: { [weak self] in
                                        self?.didTabChartsButton()
                                      }),
           ExampleCollectionViewModel(name: "코어애니메이션",
                                      backgroundImage: "그래프", handler: { [weak self] in
                                        self?.didTabCoreAnimationButton()
                                      }),
           ExampleCollectionViewModel(name: "스피너버튼",
                                      backgroundImage: "스피너버튼", handler: { [weak self] in
                                        self?.didTabSpinnerButton()
                                      }),
           ExampleCollectionViewModel(name: "프로필 바꾸기",
                                      backgroundImage: "프로필사진", handler: { [weak self] in
                                        self?.didTabCamera2Button()
                                      }),
           ExampleCollectionViewModel(name: "텍스트필드",
                                      backgroundImage: "텍스트필드", handler: { [weak self] in
                                        self?.didTabFloatingTextButton()
                                      })
        
          ])])
        
        viewModels.append([ExampleTableViewCellModel(title: "간단한 앱", viewModels:
          [ExampleCollectionViewModel(name: "알람앱",
                                      backgroundImage: "알람앱", handler: { [weak self] in
                                        self?.didTabAlarmButton()
                                      }),
           ExampleCollectionViewModel(name: "뉴스앱",
                                       backgroundImage: "뉴스앱", handler: { [weak self] in
                                         self?.didTabNewsAppButton()
                                       }),
           ExampleCollectionViewModel(name: "메모앱",
                                       backgroundImage: "메모앱", handler: { [weak self] in
                                         self?.didTabMemoButton()
                                       }),
           ExampleCollectionViewModel(name: "날씨앱",
                                       backgroundImage: "날씨앱", handler: { [weak self] in
                                         self?.didTapWeatherAppButton()
                                       }),
           ExampleCollectionViewModel(name: "할일앱",
                                       backgroundImage: "", handler: { [weak self] in
                                         self?.didTapTodoAppButton()
                                       }),
          
         
          ])])
        viewModels.append([ExampleTableViewCellModel(title: "패턴", viewModels:
          [ExampleCollectionViewModel(name: "DataSourcePattern",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTapDataSourceButton()
                                      }),
            ExampleCollectionViewModel(name: "MVPPattern",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTapMVPButton()
                                      }),
           ExampleCollectionViewModel(name: "MVVM이벤트패턴",
                                      backgroundImage: "", handler: { [weak self] in
                                        self?.didTabMVVMButton()
                                      })
           
          ])])
    }
    
    @objc func didTapButton() {
        print("1")
    }
    
    //MARK: - 뷰전환
    
    //action에 들어갈 기능구현 /  뷰전환은 여기에서 배우시면 될거 같습니다.
    @objc func didTabAnimatedButton() {
        let tabBarVC = AnimatedCustomTabBarController()
        present(tabBarVC, animated: true, completion: nil)
    }
    @objc func didTabGradientButton() {
        let gradientVC = GradientViewController()
        present(gradientVC, animated: true, completion: nil)
    }
    @objc func didTabDateFormatterButton() {
        let dateFormatterVC = DateFormatterViewController()
        present(dateFormatterVC, animated: true, completion: nil)
    }
    @objc func didTabCheckButton() {
        let checkVC = CheckViewController()
        present(checkVC, animated: true, completion: nil)
    }
    //스토리 보드를 통해서 뷰전환 / 각각의 스타일 들을 만들어 놓았으니 시뮬레이터를 플레이 해보시면서 어떤 차이점이 있는지 찾아보시면 도움이 될거 같습니다.
    @objc func didTabAlarmButton() {
        if let alarmVc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmVC") {
            alarmVc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(alarmVc, animated: true)
        }
    }
    @objc func didTabColorWellButton() {
        let colorWellVC = ColorWellViewController()
        colorWellVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(colorWellVC, animated: true, completion: nil)
    }
    @objc func didTabFontPickerButton() {
        let fontPickerVC = FontPickerViewController()
        fontPickerVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(fontPickerVC, animated: true, completion: nil)
    }
    @objc func didTabCustomTabBarButton() {
        if let customTabBarVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") {
            self.present(customTabBarVc, animated: true)
        }
    }
    @objc func didTabPDFButton() {
        if let pdfkitVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFkitVC") {
        self.present(pdfkitVC, animated: true, completion: nil)
        }
    }
    @objc func didTabSpinnerButton() {
        let spinnerVC = SpinnerViewController()
        present(spinnerVC, animated: true, completion: nil)
    }
    @objc func didTabWebButton() {
        let webVC = WebViewController()
        present(webVC, animated: true, completion: nil)
    }
    //네비게이션을 통한 뷰 전환
    @objc func didTabBarButtonItem() {
        let barButtonItemlVC = BarButtonItemViewController()
        self.navigationController?.pushViewController(barButtonItemlVC, animated: true)
    }
    @objc func didTabTextFieldAlertButton() {
        let TextFieldAlertVC = TextFieldAlertViewController()
        present(TextFieldAlertVC, animated: true, completion: nil)
    }
    @objc func didTabCheckBoxButton() {
        let vc = CheckBoxViewController()
        present(vc, animated: true, completion: nil)
    }
    @objc func didTabTableViewButton() {
        let tableVC = TableViewController()
        present(tableVC, animated: true, completion: nil)
    }
    @objc func didTabKeyboardBarButton() {
        let keyboradlVC = KeyboardToolBarViewController()
        self.navigationController?.pushViewController(keyboradlVC, animated: true)
    }
    @objc func didTabCollectionViewButton() {
        let CollectionVC = CollectionViewController()
        present(CollectionVC, animated: true, completion: nil)
    }
    @objc func didTabChartsButton() {
        let ChartsVC = BarViewController()
        self.navigationController?.pushViewController(ChartsVC, animated: true)
    }
    @objc func didTabCoreAnimationButton() {
        let CoreVC = CoreAnimationViewController()
        self.navigationController?.pushViewController(CoreVC, animated: true)
    }
    @objc func didTabAudioButton() {
        let AudioVC = AudioViewController()
        present(AudioVC, animated: true)
    }
    @objc func didTabTimerButton() {
        if let TimerVC = self.storyboard?.instantiateViewController(withIdentifier: "TimerVC") {
        self.present(TimerVC, animated: true, completion: nil)
        }
    }
    @objc func didTabCameraButton() {
        if let CameraVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") {
            self.navigationController?.pushViewController(CameraVC, animated: true)
        }
    }
    @objc func didTabCamera2Button() {
        if let CameraVC = self.storyboard?.instantiateViewController(withIdentifier: "Camera2VC") {
            self.navigationController?.pushViewController(CameraVC, animated: true)
        }
    }
   
    @objc func didTabNewsAppButton() {
        let NewsVC = NewsViewController()
            self.navigationController?.pushViewController(NewsVC, animated: true)
    }
    @objc func didTabMVVMButton() {
        let vc = MVVMEventViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTaMultipleButton() {
        let vc = MultipleCellViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapWeatherAppButton() {
        let vc = WeatherViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapTodoAppButton() {
        let vc = TodoListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapMVPButton() {
        let vc = UserViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapDataSourceButton() {
        let vc = DataSourceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapNotificationButton() {
        let vc = NotificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTabAutoButton() {
        let AutoVC = AutoLayoutViewController()
        self.navigationController?.pushViewController(AutoVC, animated: true)
    }
    @objc func didTabMemoButton() {
        if let MemoVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoVC") {
            self.navigationController?.pushViewController(MemoVC, animated: true)
        }
    }
    @objc func didTabStackButton() {
        let stackVC = StackViewController()
        present(stackVC, animated: true)
    }
    @objc func didTabUsingTimerButton() {
        let usingTimerVC = UsingTimerViewController()
        present(usingTimerVC, animated: true)
    }
    @objc func didTabCustomcellsButton() {
        let customCellVC = CustomCellsViewController()
        self.navigationController?.pushViewController(customCellVC, animated: true)
    }
    @objc func didTabPageControlButton() {
        let pageVC = PageControlViewController()
        present(pageVC, animated: true)
   }
    @objc func didTabFloatingTextButton() {
        let TextFieldVC = FloatingTextViewController()
        present(TextFieldVC, animated: true)
   }
    @objc func didTabProgressBarButton() {
        let vc = ProgressBarViewController()
        present(vc, animated: true)
   }
    @objc func didTabSegmentedButton() {
        let vc = SegmentedViewController()
        present(vc, animated: true)
   }
    @objc func didTapDatePickerButton() {
        let vc = DatePickerViewController()
        present(vc, animated: true)
   }
    @objc func didTapBottomCard() {
        let vc = BottomCardViewController()
        present(vc, animated: true)
   }
    @objc func didTapCustomProgressCircle() {
        let vc = CustomProgressBarViewController()
        present(vc, animated: true)
   }
    @objc func didTapCustomProgressBar() {
        let vc = asdfViewController()
        present(vc, animated: true)
   }
}



extension ExampleViewController: UITableViewDelegate, UITableViewDataSource, ExampleCollectionTableViewCellDelegate {
    
    func collectionTableViewCellDidTabItem(with viewModel: ExampleCollectionViewModel) {
        viewModel.handler()
    }
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.section][indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as? ExampleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/2.9
    }
    
    
}


