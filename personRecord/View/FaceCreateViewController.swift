//
//  FaceCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/12.
//

import UIKit
import RealmSwift

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
    
    //名前
    @IBOutlet weak var nameLabel: UILabel!
    
    var backNumber = 0
    var outlineNumber = 0
    var frontNumber = 0
    
    let realm = try! Realm()
    var person: Person!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = person.name
        print("DEBUG_PRINT name:\(person.name)")
        
        // Do any additional setup after loading the view.
        self.view.bringSubviewToFront( backHair )
        self.view.bringSubviewToFront( outline )
        self.view.bringSubviewToFront( frontHair )
        self.view.bringSubviewToFront( sumple )
        
        backHair.image = UIImage(named: "back1")
        outline.image = UIImage(named: "outline3")
        frontHair.image = UIImage(named: "front1")
        sumple.image = UIImage(named: "expression0")
        
    }
    
    
    @IBAction func backhairChange(_ sender: Any) {
        
        backNumber = Int(backHair_slider.value)
        backHair.image = UIImage(named: "back\(backNumber)")
    }
    
    @IBAction func fronthairChange(_ sender: Any) {
        
        frontNumber = Int(frontHair_slider.value)
        frontHair.image = UIImage(named: "front\(frontNumber)")
    }
    
    @IBAction func outlineChange(_ sender: Any) {
        
        outlineNumber = Int(outline_slider.value)
        outline.image = UIImage(named: "outline\(outlineNumber)")
    }
    
    @IBAction func SaveFace(_ sender: Any) {
        
        try! realm.write{
            
            self.person.back = "back\(backNumber)"
            self.person.outline = "outline\(outlineNumber)"
            self.person.front = "front\(frontNumber)"
            print("DEBUG_PRINT\(person.back)")
            
            
            self.realm.add(self.person, update: .modified)
        }
        
        let expressionVC = self.storyboard!.instantiateViewController(identifier: "expression") as! FaceExpressionViewController
        expressionVC.backNumber = self.backNumber
        expressionVC.outlineNumber = self.outlineNumber
        expressionVC.frontNumber = self.frontNumber
        
        expressionVC.person = self.person
        self.navigationController!.pushViewController(expressionVC, animated: true)
        
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
