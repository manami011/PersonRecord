//
//  ImageData.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/16.
//

import Foundation
import UIKit


struct nameImageData {
   
    var imageArray: [UIImage] = []

    
    mutating func changeImage(imageName: String, sliderNum1: Int, sliderNum2: Int){
        
        switch imageName {
        case "back":
            var backImage = UIImage(named: "b\(sliderNum1)\(sliderNum2)")
            
        default:
            print("一致するものがありません")
        }
        
        
    }

}
