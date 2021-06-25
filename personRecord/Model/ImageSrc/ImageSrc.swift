//
//  ImageSrc.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/24.
//

import Foundation

//素材パーツ構造体　の練習
struct ImageSrc {
    
    enum PartsType{
        
        case frontHair
        case backHair
        case outline
        case eye
        case eyebrows
        case mouth
        case hokuro
        case glassese
        case beard
        
        enum PartsColorNumber: Int{
            
            case a = 0
            case b = 1
            case c = 2
            case d = 3
            case e = 4
            case f = 5
            
        }
    
    
    func createImage(type: PartsType, num: Int){
        
        
        switch type{
        case .frontHair:
            print("frontHairです。")
            
        case .backHair:
            <#code#>
        case .outline:
            <#code#>
        case .eye:
            <#code#>
        case .eyebrows:
            <#code#>
        case .mouth:
            <#code#>
        case .hokuro:
            <#code#>
        case .glassese:
            <#code#>
        case .beard:
            <#code#>
        }
        
        }
    }
 
    
    
}
