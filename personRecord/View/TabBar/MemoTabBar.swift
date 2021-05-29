//
//  MemoTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/20.
//

import UIKit

class MemoTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TabBarのカスタマイズ
        UITabBar.appearance().tintColor = UIColor.MyTheme.iconColor
        UITabBar.appearance().barTintColor = UIColor.MyTheme.tabBarColor
        
        self.navigationItem.hidesBackButton = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
