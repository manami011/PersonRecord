//
//  NameCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/14.
//

import UIKit
import RealmSwift
import MBProgressHUD
import SVProgressHUD

class NameCreateViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var furiganaLabel: UITextField!
    
    
    let realm = try! Realm()
    //var person: Person?
    //var personCategory: PersonCategory?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        
    }
    
    
    @IBAction func CreatePerson(_ sender: Any) {
        
        if nameLabel.text == ""{
            SVProgressHUD.showError(withStatus: "名前を入力してください")
            return
        }
        if furiganaLabel.text == ""{
            SVProgressHUD.showError(withStatus: "ふりがなを入力してください")
            return
        }
        
        let person = Person()
        let allPerson = realm.objects(Person.self)
        print("DEBUG_PRINT:人物作成：allPersones:\(allPerson.count)")
        
        if allPerson.count != 0{
            person.id = allPerson.max(ofProperty: "id")! + 1
        }
       
        SVProgressHUD.show()
        SVProgressHUD.dismiss()
        person.name = nameLabel.text!
        person.furigana = furiganaLabel.text!
        
        let personCategory = PersonCategory()
        personCategory.person = person
        
        //TODO:作成途中で戻る時にはここで保存する？
        /*
        try! realm.write{
            
            person.name = nameLabel.text!
            person.furigana = furiganaLabel.text!
            self.realm.add(person, update: .modified)
        }
 */
     
        //TabBar以下のViewControllersに値を渡す
        let portraitTabbar = self.storyboard!.instantiateViewController(identifier: "portrait") as! PortraitTabBar
        
        let face1VC = portraitTabbar.self.viewControllers![0] as! FaceCreateViewController
        let face2VC = portraitTabbar.self.viewControllers![1] as! FaceCreate2ViewController
        let face3VC = portraitTabbar.self.viewControllers![2] as! FaceCreate3ViewController
        let face4VC = portraitTabbar.self.viewControllers![3] as! FaceCreate4ViewController
        face1VC.person = person
        face1VC.personCategory = personCategory
        face2VC.person = person
        face2VC.personCategory = personCategory
        face3VC.person = person
        face3VC.personCategory = personCategory
        face4VC.person = person
        face4VC.personCategory = personCategory
        
        self.navigationController!.pushViewController(portraitTabbar, animated: true)
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.popViewController(animated: true)
        
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
