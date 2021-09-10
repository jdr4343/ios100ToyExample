//
//  ViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
//앱의 해상도 대응을 신경써서 만들어지지 않았습니다. 시뮬레이터를 아이폰 11로 변경해주세요.버튼이 아닌 단일 뷰로 보고싶으시다면 Main 스토리보드의 class를 변경하여 주세요.
//가르치고자 함이 아닌 같이 배우자는 취지로 만들었습니다. 참고로 저는 배운지 2개월 됬습니다.틀린 부분이 있을수 있으며 있을경우 댓글을 남겨주시면 다시 배우겠습니다!


import UIKit
import Floaty
import FirebaseAuth

class ExampleListViewController: UIViewController {

    //버튼 추가 / 속성 추가 / 반복적인 사이즈 조절과 해상도 대응을 위해 FrameExtensions파일에 구현해놓았습니다! 사이즈 구현에서 원한대로 구현이 안된다면 FrameExtensions의 파일의 코드가 없는 것이니 복사해 가시길 바랍니다
    
  
    
   
   
   
   
 
  
 
    
   
   
  
   
  
 


  
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "100가지 예제"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
  
       
        
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
