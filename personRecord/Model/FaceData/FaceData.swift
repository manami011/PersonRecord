//
//  FaceDataViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/10.
//

import Foundation
import UIKit

    struct FaceData {
        //Imageの管理----------------
        //髪、輪郭
        var backNumber = 0
        var frontNumber = 0
        var outlineNumber = 0
        
        //目、眉毛,口
        var eyeNumber = 0
        var eyebrowsNumber = 0
        var mouthNumber = 0
        
        //ひげ,メガネ,ほくろ
        var beardNumber = 0
        var glassesNumber = 0
        var hokuroNumber = 0
        
        //色の管理（色が変えられるもの）-------------------
        
        //髪の毛、肌
        var haircolorNumber = 2
        var outlinecolorNumber = 0
        
        //眉毛
        var eyebrowscolorNumber = 0
        
        //ひげ、メガネ
        var beardcolorNumber = 0
        var glassescolorNumber = 0
        
        
        //目、口、　ほくろ
        var eyecolorNumber = 0
        var mouthcolorNumber = 0
        var hokurocolorNumber = 0
        
        var numArray: [Int] = []
        var faceImageArray: [UIImageView] = []
        
        //numArray初期化
        mutating func setNumArray(){
            
            numArray = [backNumber, frontNumber, outlineNumber, eyeNumber, eyebrowsNumber, mouthNumber, beardNumber, glassesNumber, hokuroNumber, haircolorNumber, outlinecolorNumber,eyebrowscolorNumber, beardcolorNumber, glassescolorNumber]
        }
        
        
        
        mutating func setNumber(name: String, num: Int){
            
            switch name {
            case "back":
                self.backNumber = num
                
            case "front":
                self.frontNumber = num
                
            case "outline":
                self.outlineNumber = num
                
            case "eye":
                self.eyeNumber = num
                
            case "eyebrows":
                self.eyebrowsNumber = num
                
            case "mouth":
                self.mouthNumber = num
                
            case "beard":
                self.beardNumber = num
                
            case "glasses":
                self.glassesNumber = num
                
            case "hokuro":
                self.hokuroNumber = num
                
            case "haircolor":
                self.haircolorNumber = num
                
            case "outlinecolor":
                self.outlinecolorNumber = num
                
            case "eyebrowscolor":
                self.eyebrowscolorNumber = num
                
            case "beardcolor":
                self.beardcolorNumber = num
                
            case "glassescolor":
                self.glassescolorNumber = num
                
            default:
                print("その番号は存在しません！")
            }
            
        }
        
        mutating func getImageSouce(name: String, num1: Int, num2: Int) -> UIImage{
            
            var imageName = ""
            
            switch name {
            
            case "back":
                imageName = "b\(num1)\(num2)"
                
            case "front":
                imageName = "f\(num1)\(num2)"
                
            case "outline":
                imageName = "o\(num1)\(num2)"
                
            case "eye":
                imageName = "eye\(num1)\(num2)"
                
            case "eyebrows":
                imageName = "eb\(num1)\(num2)"
                
            case "mouth":
                imageName = "m\(num1)\(num2)"
                
            case "beard":
                imageName = "be\(num1)\(num2)"
                
            case "glasses":
                imageName = "g\(num1)\(num2)"
                
            case "hokuro":
                imageName = "h\(num1)\(num2)"
                
            default:
                print("どのイメージ番号でもありません")
            }
            return UIImage(named: imageName)!
        }
        
        
        
        mutating func ImageArray() -> [UIImage]{
            
            let back = self.getImageSouce(name: "back", num1: backNumber, num2: haircolorNumber)
            let front = self.getImageSouce(name: "front", num1: frontNumber, num2: haircolorNumber)
            let outline = self.getImageSouce(name: "outline", num1: outlineNumber, num2: outlinecolorNumber)
            let eye = self.getImageSouce(name: "eye", num1: eyeNumber, num2: eyecolorNumber)
            let eyebrows = self.getImageSouce(name: "eyebrows", num1: eyebrowsNumber, num2: eyebrowscolorNumber)
            let mouth = self.getImageSouce(name: "mouth", num1: mouthNumber, num2: mouthcolorNumber)
            let beard = self.getImageSouce(name: "beard", num1: beardNumber, num2: beardcolorNumber)
            let glasses = self.getImageSouce(name: "glasses", num1: glassesNumber, num2: glassescolorNumber)
            let hokuro = self.getImageSouce(name: "hokuro", num1: hokuroNumber, num2: hokurocolorNumber)
            
            return [back, front, outline, eye, eyebrows, mouth, beard, glasses, hokuro]
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


