//
//  SavePersonViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift

class SavePersonViewController: UIViewController {
    
    @IBOutlet weak var BackHair: UIImageView!
    @IBOutlet weak var Fronthair: UIImageView!
    @IBOutlet weak var Outline: UIImageView!
    @IBOutlet weak var Expression: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var relationshipLabel: UILabel!
    
    
    let realm = try! Realm()
    var person: Person!
    var memo: Memo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        BackHair.image = UIImage(named: "\(person.back)")
        Fronthair.image = UIImage(named: "\(person.front)")
        Outline.image = UIImage(named: "\(person.outline)")
        Expression.image = UIImage(named: "\(person.exprassion)")
        
        nameLabel.text = self.person.name
        //relationshipLabel.text = self.memo.memo
        
    }
    
    
    @IBAction func SavePerson(_ sender: Any) {
        
        try! realm.write{
            
            self.realm.add(self.person, update: .modified)
        }
        
        let homeVC = self.storyboard!.instantiateViewController(identifier: "home") as! ViewController
        self.navigationController!.pushViewController(homeVC, animated: true)
        
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
