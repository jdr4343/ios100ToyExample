//
//  ComposeViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import UIKit

class ComposeViewController: UIViewController {

    var editTarget: Memo?
    //보기화면에서 편집버튼을 탭하면 메모가 이속성으로 전달됩니다. 이속성에 memo가 저장되어 있다면 편집화면으로 동작해야합니다.그리고 목록화면에서 +버튼을 탭하면 전달되는 메모가 없습니다 다시말해서 이속성이 닐이고 이때는 새메모 쓰기 모드로 동작해야 합니다.
    var originalMemoContent: String?
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //모달방식을 닫을때는 dismiss 메소드를 사용.
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func SaveBtn(_ sender: Any) {
        
        guard let memo = memoTextView.text,memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
            //사용자가 메모를 입력하지 않으면 경고창이 표시되고 메소드가 종료 됩니다.반대로 메모를 정상적으로 입력했다면 가드문 다음에 있는 코드가 실행 됩니다.
        }
        
       //let newMemo = Memo(content: memo)
       //Memo.dummyMemoList.append(newMemo)
   
        //새로운 메모를 계속 저장 편집 모드인 경우에는 새로운 메모를 추가하는게 아니라 편집한 내용을 저장하도록 바꿔야 합니다.
        if let target = editTarget {
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memodidChange, object: nil)
        } else {
            //DaraManager에서 만든 addNewmemo 호출
                DataManager.shared.addNewMemo(memo)
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
            // 이코드는 라디오 방송국에서 라디오 방송을 브로드캐스트하는것과 같습니다.
            
        }
       
        
        dismiss(animated: true, completion: nil)
      
    }
    // 글이 길어질경우 키보드에 글이 가려 수정이 어려운 문제 해결.
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    //옵저버 해제
    deinit {
        if let token = willShowToken {
            NotificationCenter.default.removeObserver(token)
            //화면이 제거되는 시점에 옵저버 해제
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//이 메소드는 뷰컨트롤러가 생성된 다음에 호출됩니다. 보통 한번만 실행되는 초기화 코드는 여기에서 구현합니다./
        if let memo = editTarget {
            //editTarget 속성에 memo가 저장되어 있다면 title을 memo 편집으로 설정하고 textview에 편집할 memo를 편집하겠습니다.
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
            originalMemoContent = memo.content
        }else{
            navigationItem.title = "새 메모"
            memoTextView.text = " "
            //반대로 전달됨 메모가 없다면 그냥 쓰기 모드입니다. 그러면 Navigationtitle은 새 메모로 설정하고 textView는 빈 문자열로 초기화 하겠습니다.
        }
        memoTextView.delegate = self
        
        //키보드가 표시되기 전에 전달되는 notification 처리
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            //클로저에서 키보드 높이 만큼 여백을 추가, 고정된 값을 입력하지 않고 notification 전달된 값을 활용해서 높이를 전달
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frame.cgRectValue.height//height 속성에 키보드 높이 저장
                //텍스트 뷰 여백 contentInset 설정, 현재설정되어 있는 값 변수에 저장
                var inset = strongSelf.memoTextView.contentInset
                inset.bottom = height// bottom 속성을 키보드 높이로 교체
                //변경한 inset을 contentinset 속성에 저장
                strongSelf.memoTextView.contentInset = inset
                
                //스크롤바에 같은크기의 여백 추가
                inset = strongSelf.memoTextView.verticalScrollIndicatorInsets
                inset.bottom = height
                strongSelf.memoTextView.verticalScrollIndicatorInsets = inset
            
            }
        })
        //키보드가 사라질떄 여백을 제거 하는 코드 구현, 새로운 옵저버를 추가하는 코드는 addObserver 메소드를 호출하는 코드 다음에 추가해야됨
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            //현재 인셋을 변수에 저장 한다음에 바텀을 0 으로 바꿔주면 됩니다. 이전과 마찬가지로 스크롤 인디케이터도 함꼐 바꿔 줘야 합니다
            var inset = strongSelf.memoTextView.contentInset
            inset.bottom = 0
            strongSelf.memoTextView.contentInset = inset
            
            inset = strongSelf.memoTextView.verticalScrollIndicatorInsets
            inset.bottom = 0
            strongSelf.memoTextView.verticalScrollIndicatorInsets = inset
            //ios 13 부터는 scrollIndicatorInsets을 해제 하라고해서 해제 erticalScrollIndicatorInsets 교체 나중에 확인해볼것
        })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //우리가 원하는 기능을 구현하기 위해서는 presentationController.delegate 추가로 설정해야합니다.
        
        // 화면에 진입하면 바로 키보드가 생성돼 바로 입력할수있도록 구현.textView 를 first Responder 로 만들어주면 텍스트뷰가 선택되고 키보드가 자동으로 표시됩니다.
        memoTextView.becomeFirstResponder()
        
       navigationController?.presentationController?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //resignFirstResponder를 생성하면 입력포커스가 제거되고 키보드가 사라집니다
        memoTextView.resignFirstResponder()
        navigationController?.presentationController?.delegate = nil
        //이렇게 하면 편집화면이 표시되기 직전에 delegate로 설정되었다가 편집화면이 사라지기 직전에 delegate가 해제 됩니다.
    }
}
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //이메소드는 텍스트 뷰에서 텍스트를 편집할떄마다 반복적으로 호출됩니다.
        if let original = originalMemoContent, let edited = textView.text {
            isModalInPresentation = original != edited
            //오리지날 메모와 편집된 내용이 다를때 isModalInPresentation 속성에 트루를 저장하겠습니다.
        
        }
    }
}

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        //텍스트 뷰에서 메모를 편집하면 조금전에 구현했던 textViewDidChange가 호출되고 오리지날 메모와 편집된 메모가 다르다면 isModalInPresentation 속성에 트루가 저장됩니다. 이상태에서 시트를 풀다운 하면 시트가 사라지지 않고 \ 이메소드가 호출됩니다.
        //경고창 추가 저장과 취소를 선택
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            self?.SaveBtn(action)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] (action) in
            self?.cancelBtn(action)
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ComposeViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMamoDidInsert")
    //라디오 방송국의 주파수 라고 생각하면 됨 라디오는 주파수로 구분하지만 노티는 이름으로 구분함
    static let memodidChange = Notification.Name("memoDidChange")
}
