//
//  ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/11.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
   
    let realm = try! Realm()
    var searchResult : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchResult = realm.objects(Person.self)
    }
    
    //追加ボタン
    @IBAction func faceCreate(_ sender: Any) {
        
        let person = Person()
        let allPersones = realm.objects(Person.self)
        person.id = allPersones.max(ofProperty: "id")! + 1
        
        try! realm.write{
            self.realm.add(person, update: .modified)
        }
        
        let nameCreateVC = self.storyboard!.instantiateViewController(identifier: "name") as! NameCreateViewController
        nameCreateVC.person = person
        self.navigationController?.pushViewController(nameCreateVC, animated: true)
    }
    
    
    //データの数(＝セルの数)を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult!.count
    }
    
    //各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        let person = searchResult![indexPath.row]
        cell.textLabel?.text = person.name
        
        
        return cell
    }
    
    //セルをタップした時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    


}

