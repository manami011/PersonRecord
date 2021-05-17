//
//  MemoCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift

class MemoCreateViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memoTextField: UITextField!
    
    
    let realm = try! Realm()
    var person: Person!
    var memo: Memo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = person.name
        
    }
    
    //ToDo:Memoを決まった項目ではなく、新規で作れるようにする。
    //各項目のタイトルLabel、memoTextFieldを配列に保存？
    @IBAction func saveMemo(_ sender: Any) {
        
        
        try! realm.write{
            
            let memo = Memo()
            let allMemos = realm.objects(Memo.self)
            memo.id = allMemos.max(ofProperty: "id")! + 1
            memo.memo = memoTextField.text!
            self.person.contents.append(memo)
            
            self.realm.add(self.person, update: .modified)
            self.realm.add(memo, update: .modified)
        }
        
        let savePersonVC = self.storyboard!.instantiateViewController(identifier: "savePerson") as! SavePersonViewController
        savePersonVC.person = self.person
        savePersonVC.memo = memo
        self.navigationController!.pushViewController(savePersonVC, animated: true)
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
