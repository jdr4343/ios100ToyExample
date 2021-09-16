//
//  AppDelegate.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
import Firebase
import FirebaseMessaging
import UserNotificationsUI
import UIKit
import FBSDKCoreKit
//페이스북 로그인
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    asfasdfsadfasdf
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        //파이어베이스
        FirebaseApp.configure()
        //파이어베이스 메시지 알람
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else {
                return
            }
            print("레지스터 등록이 성공 했습니다.")
        }
        application.registerForRemoteNotifications()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }
    
    //메시지 알람 / 토큰
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else  {
                return
            }
            print("토큰 (\(token))")
            //구현 대기 애플 대기중.. https://developer.apple.com/account/resources/authkeys/add 여기에 등록하면 됩니다.
        }
    }

}
    
