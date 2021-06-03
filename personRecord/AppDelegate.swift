//
//  AppDelegate.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/11.
//

import UIKit
import Onboard
import EAIntroView

@main

//MARK:チュートリアルのextension


//extension AppDelegate {
    /// チュートリアル画面の初期設定
    
//    func walkThrough(){
//
//        let page1 = EAIntroPage()
//        page1.title = "初めまして！"
//        page1.desc = "インストールありがとうございます！"
//        page1.bgImage = UIImage(named: "wbg")
//
//        let page2 = EAIntroPage()
//        page2.title = "このアプリでは、人物の記録ができます！"
//        page2.desc = "まずは、ホーム画面右上の＋ボタンから、覚えたい人物を登録してみましょう！"
//        page2.bgImage = UIImage(named: "wbg")
//
//        let page3 = EAIntroPage()
//        page3.title = "はじめてみましょう！"
//        page3.desc = "タグ検索もできます！"
//        page3.bgImage = UIImage(named: "wbg")
//        page3.titleFont = UIFont(name: "System", size: 20)
//        page3.titleColor = UIColor.orange
//        page3.descPositionY = self.view.bounds.size.height/2
//
//        let introView = EAIntroView(frame: self.view.bounds, andPages: [page1, page2, page3])
//        introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
//        introView?.delegate = self
//        introView?.show(in: self.view, animateDuration: 1.0)
//
//    }
    
    
//    func setOnBoard(_ application: UIApplication) {
//        print("setOnBoardメソッド初め")
//
//        if true {
//            print("setOnBoardメソッドの中　true")
//            let content1 = OnboardingContentViewController(
//                title: "titleだよ",
//                body: "bodyだよ",
//                image: nil,
//                buttonText: "",
//                action: nil
//            )
//            let content2 = OnboardingContentViewController(
//                title: "Titleだよ",
//                body: "Bodyだよ",
//                image: nil,
//                buttonText: "",
//                action: nil
//            )
//            let content3 = OnboardingContentViewController(
//                title: "Titleだよ",
//                body: "Bodyだよ",
//                image: nil,
//                buttonText: "はじめる",
//                action: {
//                    //遷移
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let homeView = storyboard.instantiateViewController(withIdentifier: "homeTab")as! HomeTabBar
//                    self.window?.rootViewController = homeView
//                    self.window?.makeKeyAndVisible()
//                    //skipボタンを押したときに, 初回起動ではなくす
//                    UserDefaults.standard.set(true, forKey: "firstLaunch")
//                }
//            )
//
//            let bgImage = UIImage(named: "UI16")
//            let vc = OnboardingViewController(
//                backgroundImage: bgImage,
//                contents: [content1, content2, content3]
//            )
//
//            vc?.allowSkipping = true
//            vc?.skipHandler = {
//                print("skip")
//                //遷移
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let homeView = storyboard.instantiateViewController(withIdentifier: "Map")as! ViewController
//                self.window?.rootViewController = homeView
//                self.window?.makeKeyAndVisible()
//                //skipボタンを押したときに, 初回起動ではなくす
//                UserDefaults.standard.set(true, forKey: "firstLaunch")
//            }
//
//
//            // 最後のページが表示されるとき, skipボタンを消す
//            content3.viewWillAppearBlock = {
//                    vc?.skipButton.isHidden = true
//            }
//
//            // 最後のページが消えるとき, skipボタンを表示(前ページに戻った場合のため)
//            content3.viewDidDisappearBlock = {
//                    vc?.skipButton.isHidden = false
//            }
//
//            window?.rootViewController = vc
//        }
//        print("setOnBoardメソッド終わり")
//    }
//}


//MARK:AppDelegate class

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //画面分岐に関する処理
//                let userDefault = UserDefaults.standard.bool(forKey: "firstLaunch")
//                print("userDefault:\(userDefault)")
//
//
//        print("起動したよ！！！")
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

