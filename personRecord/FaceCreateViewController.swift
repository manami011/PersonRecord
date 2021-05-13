//
//  FaceCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/12.
//

import UIKit

class FaceCreateViewController: UIViewController {
    
    //人の顔
    @IBOutlet weak var backHair: UIImageView!
    @IBOutlet weak var outline: UIImageView!
    @IBOutlet weak var frontHair: UIImageView!
    
    @IBOutlet weak var sumple: UIImageView!
    
    //スライダー
    @IBOutlet weak var backHair_slider: UISlider!
    @IBOutlet weak var frontHair_slider: UISlider!
    @IBOutlet weak var outline_slider: UISlider!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.bringSubviewToFront( backHair )
        self.view.bringSubviewToFront( outline )
        self.view.bringSubviewToFront( frontHair )
        self.view.bringSubviewToFront( sumple )
        
        backHair.image = UIImage(named: "back1")
        outline.image = UIImage(named: "face3")
        frontHair.image = UIImage(named: "front1")
        sumple.image = UIImage(named: "sumple1")
        
    }
    
    
    @IBAction func backhairChange(_ sender: Any) {
        
        let value = Int(backHair_slider.value)
        backHair.image = UIImage(named: "back\(value)")
    }
    
    @IBAction func fronthairChange(_ sender: Any) {
        
        let value = Int(frontHair_slider.value)
        frontHair.image = UIImage(named: "front\(value)")
    }
    
    @IBAction func outlineChange(_ sender: Any) {
        
        let value = Int(outline_slider.value)
        outline.image = UIImage(named: "face\(value)")
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
