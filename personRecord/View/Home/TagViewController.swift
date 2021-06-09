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
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let realm = try! Realm()
    var categorySearchResult : Results<Category>?
    var searchResult : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        tableView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        categorySearchResult = realm.objects(Category.self)
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "TagTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        
        
        //サーチバー
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "ふりがなで検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = false
        tableView.reloadData()
        print("TableView更新")
        
        searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categorySearchResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TagTableViewCell
        cell.contentView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        let category = categorySearchResult![indexPath.row]
        cell.categoryLabel.text = category.categoryName
        
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
    
    //追加ボタン
    @IBAction func CreatePerson(_ sender: Any) {
        
        let nameCreateVC = self.storyboard!.instantiateViewController(identifier: "name") as! NameCreateViewController
        nameCreateVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nameCreateVC, animated: true)
        self.navigationItem.hidesBackButton = false
    }
    
    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        
        let searchVC = self.storyboard!.instantiateViewController(identifier: "searchFilter") as! FilterSearchViewController
        searchVC.searchResult = self.searchResult
        self.navigationController?.pushViewController(searchVC, animated: true)
        
        return false
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
