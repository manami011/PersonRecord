//
//  PortraitTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/19.
//

import UIKit

class PortraitTabBar: UITabBarController, UITabBarControllerDelegate {
    
    
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
}


