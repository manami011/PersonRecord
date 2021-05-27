//
//  SearchTableViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit
import RealmSwift

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchText = ""
    var searchController = UISearchController(searchResultsController: nil)
    
    let realm = try! Realm()
    var searchResult : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //デザイン
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        tableView.backgroundColor = UIColor.MyTheme.backgroundColor
        //サーチバー
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "ふりがなで検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchResult = realm.objects(Person.self)
        
        searchController.isActive = true
        self.searchBar.becomeFirstResponder()
        
    }
    
    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
     print("searchBarShouldBeginEditing")
     searchBar.showsCancelButton = false
     searchBar.enablesReturnKeyAutomatically = false
        
        
     return true
    }
    
    
    //検索窓記入時の呼び出しメソッド
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let realm = try! Realm()
        
        if searchText.isEmpty{
            searchResult = realm.objects(Person.self)
        }else{
            //検索結果が0件だったら
            if(searchResult!.count == 0){
                //何も表示しない
                searchResult = realm.objects(Person.self).filter(NSPredicate(value: false))
                
            //検索結果が存在したら
            }else{
                searchResult = realm.objects(Person.self).filter("furigana CONTAINS %@", searchText)
                print("検索結果：\(searchResult!)")
            }
        }
        tableView.reloadData()
    }
    
    //データの数(＝セルの数)を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResult!.count
    }
    
    //各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        let person = searchResult![indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    //セルをタップした時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController:DetailViewController = self.storyboard!.instantiateViewController(identifier: "detail") as! DetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        
        print("DEBUG_PRINT:searchResult![indexPath!.row] \(searchResult![indexPath!.row])")
        
        
        detailViewController.person = searchResult![indexPath!.row]
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Deleteボタンが押された時に呼ばれる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete{
            
            //削除するタスクを取得する
            let task = self.searchResult![indexPath.row]
            //ローカル通知をキャンセルする
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            //データベースから削除する
            try! realm.write{
                self.realm.delete(self.searchResult![indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    


}
