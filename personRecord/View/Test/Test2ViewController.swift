//
//  Test2ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/26.
//

import UIKit
import RealmSwift


class Test2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var person: Person?
    var category: Category?
    var personCategory: PersonCategory?
    let realm = try! Realm()

    var categorySearchResult : Results<Category>?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        categorySearchResult = realm.objects(Category.self)
        print("categorySearchResult.count:\(categorySearchResult!.count)")
        
        // カスタムセルを登録する
                let nib = UINib(nibName: "customTableViewCell", bundle: nil)
                tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSectionだよ！")
        return categorySearchResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAtだよ！")
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! costomTableViewCell
        
        cell.cellButton.addTarget(self, action: #selector(self.tagEvent), for: UIControl.Event.touchUpInside)
        
        
        
        return cell
    }
    
    @objc func tagEvent(){
        print("ボタンがタップされました！")
        
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
