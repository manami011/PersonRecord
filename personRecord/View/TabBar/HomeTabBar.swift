//
//  HomeTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit

class HomeTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //TabBarのカスタマイズ
        UITabBar.appearance().tintColor = UIColor.MyTheme.iconColor
        UITabBar.appearance().barTintColor = UIColor.MyTheme.tabBarColor
        
        for item in (self.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: -5, right: -5)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
    }

}
