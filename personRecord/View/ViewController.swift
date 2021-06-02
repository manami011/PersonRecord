//
//  ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/11.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
   
    let realm = try! Realm()
    var searchResult : Results<Person>?
    
    //TableViewセクション
    var aResult: Results<Person>?
    var kaResult: Results<Person>?
    var saResult: Results<Person>?
    var taResult: Results<Person>?
    var naResult: Results<Person>?
    var haResult: Results<Person>?
    var maResult: Results<Person>?
    var yaResult: Results<Person>?
    var raResult: Results<Person>?
    var waResult: Results<Person>?
    var otherResult: Results<Person>?
    
    var sectionTitles = ["あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ", "その他"]
    var hiraganaArray = ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と", "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ", "ま", "み", "む", "め", "も", "や", "ゆ", "よ", "ら", "り", "る", "れ", "ろ", "わ", "を", "ん"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //デザイン
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        tableView.backgroundColor = UIColor.MyTheme.backgroundColor
        //サーチバー
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "ふりがなで検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
        
        self.navigationItem.hidesBackButton = true
        
        //五十音順に並べる
        aResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'あ') OR (furigana BEGINSWITH 'い') OR (furigana BEGINSWITH 'う') OR (furigana BEGINSWITH 'え') OR (furigana BEGINSWITH 'お')").sorted(byKeyPath: "furigana", ascending: true)
        
        kaResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'か') OR (furigana BEGINSWITH 'き') OR (furigana BEGINSWITH 'く') OR (furigana BEGINSWITH 'け') OR (furigana BEGINSWITH 'こ')").sorted(byKeyPath: "furigana", ascending: true)
        
        saResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'さ') OR (furigana BEGINSWITH 'し') OR (furigana BEGINSWITH 'す') OR (furigana BEGINSWITH 'せ') OR (furigana BEGINSWITH 'そ')").sorted(byKeyPath: "furigana", ascending: true)
        
        taResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'た') OR (furigana BEGINSWITH 'ち') OR (furigana BEGINSWITH 'つ') OR (furigana BEGINSWITH 'て') OR (furigana BEGINSWITH 'と')").sorted(byKeyPath: "furigana", ascending: true)
        
        naResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'な') OR (furigana BEGINSWITH 'に') OR (furigana BEGINSWITH 'ぬ') OR (furigana BEGINSWITH 'ね') OR (furigana BEGINSWITH 'の')").sorted(byKeyPath: "furigana", ascending: true)
        
        haResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'は') OR (furigana BEGINSWITH 'ひ') OR (furigana BEGINSWITH 'ふ') OR (furigana BEGINSWITH 'へ') OR (furigana BEGINSWITH 'ほ')").sorted(byKeyPath: "furigana", ascending: true)
        
        maResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'ま') OR (furigana BEGINSWITH 'み') OR (furigana BEGINSWITH 'む') OR (furigana BEGINSWITH 'め') OR (furigana BEGINSWITH 'も')").sorted(byKeyPath: "furigana", ascending: true)
        
        yaResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'や') OR (furigana BEGINSWITH 'ゆ') OR (furigana BEGINSWITH 'よ')").sorted(byKeyPath: "furigana", ascending: true)
        
        raResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'ら') OR (furigana BEGINSWITH 'り') OR (furigana BEGINSWITH 'る') OR (furigana BEGINSWITH 'れ') OR (furigana BEGINSWITH 'ろ')").sorted(byKeyPath: "furigana", ascending: true)
        
        waResult = realm.objects(Person.self).filter("(furigana BEGINSWITH 'わ') OR (furigana BEGINSWITH 'を') OR (furigana BEGINSWITH 'ん')").sorted(byKeyPath: "furigana", ascending: true)
        
        
        otherResult = realm.objects(Person.self).filter(
            "(NOT furigana BEGINSWITH 'あ') AND (NOT furigana BEGINSWITH 'い') AND (NOT furigana BEGINSWITH 'う') AND (NOT furigana BEGINSWITH 'え') AND (NOT furigana BEGINSWITH 'お') AND (NOT furigana BEGINSWITH 'か') AND (NOT furigana BEGINSWITH 'き') AND (NOT furigana BEGINSWITH 'く') AND (NOT furigana BEGINSWITH 'け') AND (NOT furigana BEGINSWITH 'こ') AND (NOT furigana BEGINSWITH 'さ') AND (NOT furigana BEGINSWITH 'し') AND (NOT furigana BEGINSWITH 'す') AND (NOT furigana BEGINSWITH 'せ') AND (NOT furigana BEGINSWITH 'そ') AND (NOT furigana BEGINSWITH 'た') AND (NOT furigana BEGINSWITH 'ち') AND (NOT furigana BEGINSWITH 'つ') AND (NOT furigana BEGINSWITH 'て') AND (NOT furigana BEGINSWITH 'と') AND (NOT furigana BEGINSWITH 'な') AND (NOT furigana BEGINSWITH 'に') AND (NOT furigana BEGINSWITH 'ぬ') AND (NOT furigana BEGINSWITH 'ね') AND (NOT furigana BEGINSWITH 'の') AND (NOT furigana BEGINSWITH 'は') AND (NOT furigana BEGINSWITH 'ひ') AND (NOT furigana BEGINSWITH 'ふ') AND (NOT furigana BEGINSWITH 'へ') AND (NOT furigana BEGINSWITH 'ほ') AND (NOT furigana BEGINSWITH 'ま') AND (NOT furigana BEGINSWITH 'み') AND (NOT furigana BEGINSWITH 'む') AND (NOT furigana BEGINSWITH 'め') AND (NOT furigana BEGINSWITH 'も') AND (NOT furigana BEGINSWITH 'や') AND (NOT furigana BEGINSWITH 'ゆ') AND (NOT furigana BEGINSWITH 'よ') AND (NOT furigana BEGINSWITH 'ら') AND (NOT furigana BEGINSWITH 'り') AND (NOT furigana BEGINSWITH 'る') AND (NOT furigana BEGINSWITH 'れ') AND (NOT furigana BEGINSWITH 'ろ') AND (NOT furigana BEGINSWITH 'わ') AND (NOT furigana BEGINSWITH 'を') AND (NOT furigana BEGINSWITH 'ん')"
        ).sorted(byKeyPath: "furigana", ascending: true)
 
    }
    
    //入力画面から戻ってきたときにTableViewを更新する
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = false
        tableView.reloadData()
        print("TableView更新")
    }
    
    //追加ボタン
    @IBAction func faceCreate(_ sender: Any) {
        
        let nameCreateVC = self.storyboard!.instantiateViewController(identifier: "name") as! NameCreateViewController
        nameCreateVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nameCreateVC, animated: true)
        self.navigationItem.hidesBackButton = false
    }
    
    
    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
     print("searchBarShouldBeginEditing")
        
        let searchVC = self.storyboard!.instantiateViewController(identifier: "search") as! SearchTableViewController
        searchVC.searchResult = self.searchResult
        self.navigationController?.pushViewController(searchVC, animated: true)
        
     return false
    }
    
    
    //データの数(＝セルの数)を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG_PRINT：aResult!.count\(aResult!.count)")
        
        if section == 0{
            return aResult!.count
            
        }else if section == 1{
            return kaResult!.count
            
        }else if section == 2{
            return saResult!.count
            
        }else if section == 3{
            return taResult!.count
            
        }else if section == 4{
            return naResult!.count
            
        }else if section == 5{
            return haResult!.count
            
        }else if section == 6{
            return maResult!.count
            
        }else if section == 7{
            return yaResult!.count
            
        }else if section == 8{
            return raResult!.count
            
        }else if section == 9{
            return waResult!.count
            
        }else{
            return otherResult!.count
        }
    }
        
    
    
    //各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.MyTheme.backgroundColor
        
        //Cellに値を設定する
        if indexPath.section == 0{
            let person = aResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 1{
            let person = kaResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 2{
            let person = saResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 3{
            let person = taResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 4{
            let person = naResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 5{
            let person = haResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 6{
            let person = maResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 7{
            let person = yaResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 8{
            let person = raResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else if indexPath.section == 9{
            let person = waResult![indexPath.row]
            cell.textLabel?.text = person.name
            
        }else{
            let person = otherResult![indexPath.row]
            cell.textLabel?.text = person.name
        }
        
        
        return cell
    }
    
    //セルをタップした時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController:DetailViewController = self.storyboard!.instantiateViewController(identifier: "detail") as! DetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        
        print("DEBUG_PRINT:searchResult![indexPath!.row] \(searchResult![indexPath!.row])")
        
        if indexPath?.section == 0{
            detailViewController.person = aResult![indexPath!.row]
            
        }else if indexPath?.section == 1{
            detailViewController.person = kaResult![indexPath!.row]
            
        }else if indexPath?.section == 2{
            detailViewController.person = saResult![indexPath!.row]
            
        }else if indexPath?.section == 3{
            detailViewController.person = taResult![indexPath!.row]
            
        }else if indexPath?.section == 4{
            detailViewController.person = naResult![indexPath!.row]
            
        }else if indexPath?.section == 5{
            detailViewController.person = haResult![indexPath!.row]
            
        }else if indexPath?.section == 6{
            detailViewController.person = maResult![indexPath!.row]
            
        }else if indexPath?.section == 7{
            detailViewController.person = yaResult![indexPath!.row]
            
        }else if indexPath?.section == 8{
            detailViewController.person = raResult![indexPath!.row]
            
        }else if indexPath?.section == 9{
            detailViewController.person = waResult![indexPath!.row]
            
        }else{
            detailViewController.person = otherResult![indexPath!.row]
        }
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Deleteボタンが押された時に呼ばれる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete{
            print("[indexPath.row]: \(indexPath.row)")
            
            //削除する人物を取得する
            let person = self.searchResult![indexPath.row]
            //ローカル通知をキャンセルする
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(person.id)])
            
           
            //データベースから削除する
            try! realm.write{
                
                //人物を削除したら、紐づくpersonCategoryも削除する
                //let personCategory = realm.objects(PersonCategory.self)
                for i in 0...person.personCategory.count-1{

                    self.realm.delete(person.personCategory[i])

                }
                
                self.realm.delete(person)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
    }
    
    //セクション
    func numberOfSections(in tableView: UITableView) -> Int {
           //セクションの数
           return 11
       }
       
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
        let label = UILabel()
        label.backgroundColor = UIColor.MyTheme.labelColor
        label.textColor = UIColor.MyTheme.iconColor
        label.text = sectionTitles[section]
        
        //セクションのタイトルを設定する。
        return label
       }


}

