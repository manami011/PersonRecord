//
//  FaceTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/14.
//

import UIKit

@objc protocol Slider: class{
    
    func sliderMove(numArray: [Int])
}


class FaceTabBar: UITabBarController, UITabBarControllerDelegate, Slider{
    
    func sliderMove(numArray: [Int]) {
        print("から")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
