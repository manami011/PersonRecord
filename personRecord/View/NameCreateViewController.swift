//
//  NameCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/14.
//

import UIKit
import RealmSwift

class NameCreateViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    let realm = try! Realm()
    var person: Person!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveName(_ sender: Any) {
        
        try! realm.write{
            
            self.person.name = nameLabel.text!
            
            self.realm.add(self.person, update: .modified)
        }
        
        let faceCreateVC = self.storyboard!.instantiateViewController(identifier: "faceCreate") as! FaceCreateViewController
        faceCreateVC.person = self.person
        self.navigationController!.pushViewController(faceCreateVC, animated: true)
        
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
