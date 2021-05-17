//
//  FaceExpressionViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import UIKit
import RealmSwift

class FaceExpressionViewController: UIViewController {
    

    @IBOutlet weak var BackHair: UIImageView!
    @IBOutlet weak var Outline: UIImageView!
    @IBOutlet weak var FrontHair: UIImageView!
    
    @IBOutlet weak var Expression: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //スライダー
    @IBOutlet weak var expression_slider: UISlider!
    
    
    //顔パーツの画像番号
    var backNumber = 0
    var outlineNumber = 0
    var frontNumber = 0
    
    var expressionNumber = 0
        
    
    let realm = try! Realm()
    var person: Person!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        BackHair.image = UIImage(named: "back\(backNumber)")
        Outline.image = UIImage(named: "outline\(outlineNumber)")
        FrontHair.image = UIImage(named: "front\(frontNumber)")
        Expression.image = UIImage(named: "expression0")
        
        nameLabel.text = self.person.name
        print("DEBUG_PRINT: outlineNumber\(outlineNumber)")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveExprassion(_ sender: Any) {
        
        try! realm.write{
            self.person.exprassion =  "expression\(expressionNumber)"
            self.realm.add(self.person, update: .modified)
        }
        
        let memoVC = self.storyboard!.instantiateViewController(identifier: "memo") as! MemoCreateViewController
        memoVC.person = self.person
        self.navigationController!.pushViewController(memoVC, animated: true)
        
    }
    
    @IBAction func expressionChange(_ sender: Any) {
        
        expressionNumber = Int(expression_slider.value)
        Expression.image = UIImage(named: "expression\(expressionNumber)")
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
