//
//  TagViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit
import RealmSwift
import MBProgressHUD
import SVProgressHUD

class TagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var categorySearchResult : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.MyTheme.backgroundColor
        tableView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        categorySearchResult = realm.objects(Category.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = false
        tableView.reloadData()
        print("TableView更新")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categorySearchResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        let category = categorySearchResult![indexPath.row]
        cell.textLabel?.text = category.categoryName
        
        return cell
    }
    
    //セルをタップした時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tagVC = self.storyboard!.instantiateViewController(identifier: "tagDetail") as! TagDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        print("DEBUGPRINT:indexpath\(indexPath!.row)")
        print("DEBUG_PRINT:searchResult![indexPath!.row] \(categorySearchResult![indexPath!.row])")
        
        
        tagVC.category = categorySearchResult![indexPath!.row]
        
      self.navigationController!.pushViewController(tagVC, animated: true)
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
