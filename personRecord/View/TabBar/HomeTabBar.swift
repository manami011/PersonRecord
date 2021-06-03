//
//  HomeTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit
import EAIntroView

class HomeTabBar: UITabBarController, UITabBarControllerDelegate, EAIntroDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
       
        
        //画面分岐に関する処理
                let userDefault = UserDefaults.standard.bool(forKey: "firstLaunch")
                print("userDefault:\(userDefault)")
        
                if userDefault == true {
                    // ↓画面分岐処理確認用
                    UserDefaults.standard.set(false, forKey: "firstLaunch")
                    print("初回起動でない\(userDefault)")
                } else {
                    //UserDefaults.standard.set(true, forKey: "firstLaunch")
                    print("初回起動\(userDefault)")

                    // チュートリアル画面表示
                    walkThrough()
                }
        //TabBarのカスタマイズ
        UITabBar.appearance().tintColor = UIColor.MyTheme.iconColor
        UITabBar.appearance().barTintColor = UIColor.MyTheme.tabBarColor
        
        for item in (self.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: -5, right: -5)
        }
        
    }
    
    func walkThrough(){
        
        let page1 = EAIntroPage()
        page1.title = "インストールありがとうございます！"
        page1.desc = "このアプリでは、似顔絵とタグで人物を記録することができます。\n　まずは、右上の＋ボタンから新規作成をしてみましょう。"
        page1.descAlignment = NSTextAlignment.center
        page1.bgImage = UIImage(named: "wbg1")
        
        
        let page2 = EAIntroPage()
        page2.title = "名前を入力"
        page2.bgImage = UIImage(named: "wbg2")
        page2.desc = "名前と、ふりがなをひらがなで入力します。"
        
        
        let page3 = EAIntroPage()
        page3.title = "似顔絵作成"
        page3.desc = "特徴を思い出しながら、似顔絵を作ってみましょう。"
        page3.bgImage = UIImage(named: "wbg3")
        
        let page4 = EAIntroPage()
        page4.title = "メモ・タグ"
        page4.desc = "ちょっとしたメモとタグが付けられます。\n タグは後から検索できます。"
        page4.bgImage = UIImage(named: "wbg4")
        
        let page5 = EAIntroPage()
        page5.title = "さっそくはじめてみましょう！"
        page5.titlePositionY = self.view.bounds.size.height/2 - self.view.bounds.size.height/4*1.3
        //page5.desc = "さっそく使ってみましょう！"
        page5.bgImage = UIImage(named: "wbg5")
        
        
        
        
        
        let introView = EAIntroView(frame: self.view.bounds, andPages: [page1, page2, page3, page4, page5])
        
        introView?.skipButton.isHidden = false
        introView?.skipButton.setTitle("スキップ", for: UIControl.State.normal)
        introView?.delegate = self
        introView?.show(in: self.view, animateDuration: 1.0)
         
        if introView?.currentPageIndex == 4{
            introView?.skipButton.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
    }

}
