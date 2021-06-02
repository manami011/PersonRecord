//
//  PortraitTabBar.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/19.
//

import UIKit

@objc protocol Mochi: class{
    
     func sliderMove(back:Int, front:Int, outline:Int, eye:Int, eyebrows:Int, mouth:Int, glasses:Int, hokuro:Int, beard:Int,
                    haircolor:Int, outlinecolor:Int, glassescolor:Int, beardcolor:Int)
}


class PortraitTabBar: UITabBarController, UITabBarControllerDelegate, Mochi{
    
    func sliderMove(back: Int, front: Int, outline: Int, eye:Int, eyebrows:Int, mouth:Int, glasses: Int, hokuro: Int, beard: Int, haircolor: Int, outlinecolor: Int, glassescolor: Int, beardcolor: Int) {
        
        let vc1 = self.viewControllers![0] as! FaceCreateViewController
        print("PortraitTabBar:sliderMove")
        
        vc1.backNumber = back
        vc1.frontNumber = front
        vc1.outlineNumber = outline
        
        vc1.eyeNumber = eye
        vc1.eyebrowsNumber = eyebrows
        vc1.mouthNumber = mouth
        
        vc1.glassesNumber = glasses
        vc1.hokuroNumber = hokuro
        vc1.beardNumber = beard
        
        vc1.haircolorNumber = haircolor
        vc1.outlinecolorNumber = outlinecolor
        vc1.glassescolorNumber = glassescolor
        vc1.beardcolorNumber = beardcolor
        
        
        let vc2 = self.viewControllers![1] as! FaceCreate2ViewController
        vc2.backNumber = back
        vc2.frontNumber = front
        vc2.outlineNumber = outline
        
        vc2.eyeNumber = eye
        vc2.eyebrowsNumber = eyebrows
        vc2.mouthNumber = mouth
        
        vc2.glassesNumber = glasses
        vc2.hokuroNumber = hokuro
        vc2.beardNumber = beard
        
        vc2.haircolorNumber = haircolor
        vc2.outlinecolorNumber = outlinecolor
        vc2.glassescolorNumber = glassescolor
        vc2.beardcolorNumber = beardcolor
        
        
        let vc3 = self.viewControllers![2] as! FaceCreate3ViewController
        vc3.backNumber = back
        vc3.frontNumber = front
        vc3.outlineNumber = outline
        
        vc3.eyeNumber = eye
        vc3.eyebrowsNumber = eyebrows
        vc3.mouthNumber = mouth
        
        vc3.glassesNumber = glasses
        vc3.hokuroNumber = hokuro
        vc3.beardNumber = beard
        
        vc3.haircolorNumber = haircolor
        vc3.outlinecolorNumber = outlinecolor
        vc3.glassescolorNumber = glassescolor
        vc3.beardcolorNumber = beardcolor
        
        
        let vc4 = self.viewControllers![3] as! FaceCreate4ViewController
        vc4.backNumber = back
        vc4.frontNumber = front
        vc4.outlineNumber = outline
        
        vc4.eyeNumber = eye
        vc4.eyebrowsNumber = eyebrows
        vc4.mouthNumber = mouth
        
        vc4.glassesNumber = glasses
        vc4.hokuroNumber = hokuro
        vc4.beardNumber = beard
        
        vc4.haircolorNumber = haircolor
        vc4.outlinecolorNumber = outlinecolor
        vc4.glassescolorNumber = glassescolor
        vc4.beardcolorNumber = beardcolor
        
        
        
        print("PortraitTabBar:sliderMove終わった")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //TabBarのカスタマイズ
        UITabBar.appearance().tintColor = UIColor.MyTheme.iconColor
        UITabBar.appearance().barTintColor = UIColor.MyTheme.tabBarColor
        
        for item in (self.tabBar.items)! {
            item.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: -5, right: -5)
        }
        
        let vc1 = self.viewControllers![0] as! FaceCreateViewController
        vc1.delegate = self
        let vc2 = self.viewControllers![1] as! FaceCreate2ViewController
        vc2.delegate = self
        let vc3 = self.viewControllers![2] as! FaceCreate3ViewController
        vc3.delegate = self
        let vc4 = self.viewControllers![3] as! FaceCreate4ViewController
        vc4.delegate = self
    }
}


