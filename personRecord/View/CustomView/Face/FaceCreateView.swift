//
//  FaceCreateView.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/26.
//

import UIKit

class FaceCreateView: UIView {
    
    //似顔絵
    //後ろ髪、輪郭、前髪
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var outline: UIImageView!
    @IBOutlet weak var front: UIImageView!
    
    //目、眉、口（表情）
    @IBOutlet weak var eye: UIImageView!
    @IBOutlet weak var eyebrows: UIImageView!
    @IBOutlet weak var mouth: UIImageView!
    
    
    
    //メガネ、ほくろ、ひげ
    @IBOutlet weak var glasses: UIImageView!
    @IBOutlet weak var hokuro: UIImageView!
    @IBOutlet weak var beard: UIImageView!
    
    
    //ボタン
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //アイコン
    
    @IBOutlet weak var icon1Image: UIImageView!
    @IBOutlet weak var icon2Image: UIImageView!
    @IBOutlet weak var icon3Image: UIImageView!
    @IBOutlet weak var icon4Image: UIImageView!
    
    //スライダー
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var slider4: UISlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
