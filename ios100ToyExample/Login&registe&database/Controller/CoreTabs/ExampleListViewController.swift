//
//  ViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
//앱의 해상도 대응을 신경써서 만들어지지 않았습니다. 시뮬레이터를 아이폰 11로 변경해주세요.버튼이 아닌 단일 뷰로 보고싶으시다면 Main 스토리보드의 class를 변경하여 주세요.
//가르치고자 함이 아닌 같이 배우자는 취지로 만들었습니다. 참고로 저는 배운지 2개월 됬습니다.틀린 부분이 있을수 있으며 있을경우 댓글을 남겨주시면 다시 배우겠습니다!


import UIKit
import RAMAnimatedTabBarController
import Floaty
import FirebaseAuth

class ExampleListViewController: UIViewController {

    //버튼 추가 / 속성 추가 / 반복적인 사이즈 조절과 해상도 대응을 위해 FrameExtensions파일에 구현해놓았습니다! 사이즈 구현에서 원한대로 구현이 안된다면 FrameExtensions의 파일의 코드가 없는 것이니 복사해 가시길 바랍니다
    private let animatedTabBar: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("애니메이션 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabAnimatedButton), for: .touchUpInside)
        return button
    }()
    private let gradientView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("그라데이션", for: .normal)
        button.addTarget(self, action: #selector(didTabGradientButton), for: .touchUpInside)
        return button
    }()
    private let dateFormatterView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("날짜 생성", for: .normal)
        button.addTarget(self, action: #selector(didTabDateFormatterButton), for: .touchUpInside)
        return button
    }()
    private let checkView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemTeal
        button.setTitle("체크", for: .normal)
        button.addTarget(self, action: #selector(didTabCheckButton), for: .touchUpInside)
        return button
    }()
    private let alarmView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("알람", for: .normal)
        button.addTarget(self, action: #selector(didTabAlarmButton), for: .touchUpInside)
        return button
    }()
    private let colorWellView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("색상 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabColorWellButton), for: .touchUpInside)
        return button
    }()
    private let FontPickerView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemFill
        button.setTitle("폰트 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabFontPickerButton), for: .touchUpInside)
        return button
    }()
    private let CustomTabBarView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("커스텀 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabCustomTabBarButton), for: .touchUpInside)
        return button
    }()
    private let pdfKitView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("PDF 삽입", for: .normal)
        button.addTarget(self, action: #selector(didTabPDFButton), for: .touchUpInside)
        return button
    }()
    private let spinnerView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("스피너 버튼", for: .normal)
        button.addTarget(self, action: #selector(didTabSpinnerButton), for: .touchUpInside)
        return button
    }()
    private let webView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("웹뷰", for: .normal)
        button.addTarget(self, action: #selector(didTabWebButton), for: .touchUpInside)
        return button
    }()
    private let barButtonItemView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("바 버튼", for: .normal)
        button.addTarget(self, action: #selector(didTabBarButtonItem), for: .touchUpInside)
        return button
    }()
    private let textFieldAlertView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("텍스트 경고창", for: .normal)
        button.addTarget(self, action: #selector(didTabTextFieldAlertButton), for: .touchUpInside)
        return button
    }()
    private let tableView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.setTitle("테이블 뷰", for: .normal)
        button.addTarget(self, action: #selector(didTabTableViewButton), for: .touchUpInside)
        return button
    }()
    private let keyboardBar: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("키보드 툴바", for: .normal)
        button.addTarget(self, action: #selector(didTabKeyboardBarButton), for: .touchUpInside)
        return button
    }()
    private let collectionView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .magenta
        button.setTitle("컬렉션 뷰", for: .normal)
        button.addTarget(self, action: #selector(didTabCollectionViewButton), for: .touchUpInside)
        return button
    }()
    private let chartsView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("차트/그래프", for: .normal)
        button.addTarget(self, action: #selector(didTabChartsButton), for: .touchUpInside)
        return button
    }()
    private let coreAnimationView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("코어 애니메이션", for: .normal)
        button.addTarget(self, action: #selector(didTabCoreAnimationButton), for: .touchUpInside)
        return button
    }()
    private let audioPlayView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("오디오 재생", for: .normal)
        button.addTarget(self, action: #selector(didTabAudioButton), for: .touchUpInside)
        return button
    }()
    private let timerView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("타이머", for: .normal)
        button.addTarget(self, action: #selector(didTabTimerButton), for: .touchUpInside)
        return button
    }()
    private let camerarView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("사진", for: .normal)
        button.addTarget(self, action: #selector(didTabCameraButton), for: .touchUpInside)
        return button
    }()
    private let camerar2View: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("프로필 바꾸기", for: .normal)
        button.addTarget(self, action: #selector(didTabCamera2Button), for: .touchUpInside)
        return button
    }()
    private let autoLayoutView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemTeal
        button.setTitle("오토레이아웃", for: .normal)
        button.addTarget(self, action: #selector(didTabAutoButton), for: .touchUpInside)
        return button
    }()
    private let stackView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("스택 뷰", for: .normal)
        button.addTarget(self, action: #selector(didTabStackButton), for: .touchUpInside)
        return button
    }()
    private let usingTimerView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Timer()응용", for: .normal)
        button.addTarget(self, action: #selector(didTabUsingTimerButton), for: .touchUpInside)
        return button
    }()
    private let customcellsView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("커스텀 셀", for: .normal)
        button.addTarget(self, action: #selector(didTabCustomcellsButton), for: .touchUpInside)
        return button
    }()
    private let pageControlView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("페이징 컨트롤", for: .normal)
        button.addTarget(self, action: #selector(didTabPageControlButton), for: .touchUpInside)
        return button
    }()
    private let floatingTextView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("텍스트필드", for: .normal)
        button.addTarget(self, action: #selector(didTabFloatingTextButton), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "100가지 예제"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        NotAuthenticated()
        view.addSubview(animatedTabBar)
        view.addSubview(gradientView)
        view.addSubview(dateFormatterView)
        view.addSubview(alarmView)
        floatingButton()
        view.addSubview(checkView)
        view.addSubview(colorWellView)
        view.addSubview(FontPickerView)
        view.addSubview(CustomTabBarView)
        view.addSubview(pdfKitView)
        view.addSubview(spinnerView)
        view.addSubview(webView)
        view.addSubview(barButtonItemView)
        view.addSubview(textFieldAlertView)
        view.addSubview(tableView)
        view.addSubview(keyboardBar)
        view.addSubview(collectionView)
        view.addSubview(chartsView)
        view.addSubview(coreAnimationView)
        view.addSubview(audioPlayView)
        view.addSubview(timerView)
        view.addSubview(camerarView)
        view.addSubview(camerar2View)
        view.addSubview(autoLayoutView)
        view.addSubview(stackView)
        view.addSubview(usingTimerView)
        view.addSubview(customcellsView)
        view.addSubview(pageControlView)
        view.addSubview(floatingTextView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animatedTabBar.frame = CGRect(x: 0, y: 90,
                                      width: 130, height: 50)
        gradientView.frame = CGRect(x: 130, y: 90,
                                    width: 100, height: 50)
        dateFormatterView.frame = CGRect(x: 230, y: 90
                                         ,width: 80, height: 50)
        alarmView.frame = CGRect(x: 360, y: 90
                                 ,width: 55, height: 50)
        checkView.frame = CGRect(x: 310, y: 90
                                 ,width: 50, height: 50)
        colorWellView.frame = CGRect(x: 0, y: 140
                                     ,width: 90, height: 50)
        FontPickerView.frame = CGRect(x: 90, y: 140
                                      ,width: 90, height: 50)
        CustomTabBarView.frame = CGRect(x: 180, y: 140
                                        ,width: 90, height: 50)
        pdfKitView.frame = CGRect(x: 270, y: 140
                                  ,width: 90, height: 50)
        spinnerView.frame = CGRect(x: 0, y: 190
                                   ,width: 90, height: 50)
        webView.frame = CGRect(x: 360, y: 140
                               ,width: 55, height: 50)
        barButtonItemView.frame = CGRect(x: 90, y: 190
                                         ,width: 60, height: 50)
        textFieldAlertView.frame = CGRect(x: 150, y: 190,
                                          width: 110, height: 50)
        tableView.frame = CGRect(x: 260, y: 190,
                                 width: 77, height: 50)
        collectionView.frame = CGRect(x: 335, y: 190,
                                      width: 80, height: 50)
        keyboardBar.frame = CGRect(x: 0, y: 240,
                                   width: 90, height: 50)
        chartsView.frame = CGRect(x: 90, y: 240,
                                  width: 100, height: 50)
        coreAnimationView.frame = CGRect(x: 190, y: 240,
                                         width: 120, height: 50)
        audioPlayView.frame = CGRect(x: 310, y: 240,
                                     width: 110, height: 50)
        timerView.frame = CGRect(x: 0, y: 290,
                                 width: 60, height: 50)
        camerarView.frame = CGRect(x: 60, y: 290,
                                   width: 60, height: 50)
        camerar2View.frame = CGRect(x: 120, y: 290,
                                   width: 110, height: 50)
        autoLayoutView.frame = CGRect(x: 230, y: 290,
                                      width: 110, height: 50)
        stackView.frame = CGRect(x: 340, y: 290,
                                 width: 80, height: 50)
        usingTimerView.frame = CGRect(x: 0, y: 340,
                                      width: 110, height: 50)
        customcellsView.frame = CGRect(x: 110, y: 340,
                                       width: 80, height: 50)
        pageControlView.frame = CGRect(x: 190, y: 340,
                                       width: 110, height: 50)
        floatingTextView.frame = CGRect(x: 300, y: 340, width: 120, height: 50)
        
    }
    //MARK: - Login
    
    // 사용자가 로그인 하지 않았다면 로그인 화면을 보여주고 아니라면 메인 뷰를 보여줄것입니다.
    private func NotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
    
    
    
    
    
    
    //플로팅 버튼 구현
    private func floatingButton() {
        let floating = Floaty()
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
        floating.addItem("뉴스 앱을 만들어보자!", icon: UIImage(systemName:
            "newspaper.fill")!, handler: { item in
            let  NewsVC = NewsViewController()
                self.navigationController?.pushViewController(NewsVC, animated: true)
        })
        floating.addItem("수평 슬라이드 컬렉션 테이블뷰", icon: UIImage(systemName: "slider.horizontal.below.square.fill.and.square")!, handler: { item in
            //핸들러를 열고 기능 구현을 하면 됩니다.
            let CarouselVC = CarouselViewController()
            self.present(CarouselVC, animated: true, completion: nil)
        })
        floating.addItem("동영상,수평,수직 컬렉션 테이블뷰", icon: UIImage(systemName: "square.grid.3x1.fill.below.line.grid.1x2")!, handler: { item in
            let AdvancedVC = AdvancedViewController()
            self.present(AdvancedVC, animated: true, completion: nil)
        })
        self.view.addSubview(floating)
    }

    
    
    
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
    @objc func didTabAutoButton() {
        let AutoVC = AutoLayoutViewController()
        self.navigationController?.pushViewController(AutoVC, animated: true)
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
}
