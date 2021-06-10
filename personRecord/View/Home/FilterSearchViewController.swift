//
//  FilterSearchViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/08.
//

import UIKit
import RealmSwift

class FilterSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var filterUIView: UIView!
    
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var maleButton: UIButton!
    var femaleButton: UIButton!
    var noGenderButton: UIButton!
    var longButton: UIButton!
    var middleButton: UIButton!
    var shortButton: UIButton!
    var glassesButton: UIButton!
    var hokuroButton: UIButton!
    var beardButton: UIButton!
    
    var btnArray: [UIButton] = []
    
    let realm = try! Realm()
    var searchResult : Results<Person>?
    var searchResult2 : Results<Person>?
    var searchResult3 : Results<Person>?
    var searchResult4 : Results<Person>?
    var searchResult5 : Results<Person>?
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "FilterView", bundle: nil)
        filterView = nib.instantiate(withOwner: self, options: nil).first as? FilterView
        filterUIView.addSubview(filterView)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //デザイン
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        tableView.backgroundColor = UIColor.MyTheme.backgroundColor
        //サーチバー
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "ふりがなで検索"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.isActive = true
        self.searchBar.becomeFirstResponder()
        
        
        maleButton = filterView.maleButton
        femaleButton = filterView.femaleButton
        noGenderButton = filterView.noGenderButton
        longButton = filterView.longButton
        middleButton = filterView.middleButon
        shortButton = filterView.shortButton
        glassesButton = filterView.glassesButton
        hokuroButton = filterView.hokuroButton
        beardButton = filterView.beardButton
        
        
        btnArray = [maleButton, femaleButton, noGenderButton, longButton, middleButton, shortButton, glassesButton, hokuroButton, beardButton]
        
        for btn in btnArray{
            
            btn.addTarget(self, action: #selector(self.tagChange(sender:)), for: UIControl.Event.touchUpInside)
        }
        filterStackView.bringSubviewToFront(glassesButton)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        //searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
        
        //filterView.isHidden = true
        filterUIView.isHidden = true
        filterViewHeight.constant = 0
        filterButton.setTitle("+絞り込み検索", for: UIControl.State.normal)
        filterStackView.bringSubviewToFront(filterButton)
    }
    
    @IBAction func FilterTerms(_ sender: Any) {
        
        if filterUIView.isHidden{
            //filterView.isHidden = false
            filterUIView.isHidden = false
            filterViewHeight.constant = 126
            filterButton.setTitle("-絞り込み検索", for: UIControl.State.normal)
            print("filterView.isHidden = true")
        }else{
            //filterView.isHidden = true
            filterUIView.isHidden = true
            filterViewHeight.constant = 0
            filterButton.setTitle("+絞り込み検索", for: UIControl.State.normal)
            print("filterView.isHidden = false")
        }
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
            searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
        }else{
            //検索結果が0件だったら
            if(searchResult!.count == 0){
                //何も表示しない
                searchResult = realm.objects(Person.self).filter(NSPredicate(value: false))
                
                //検索結果が存在したら
            }else{
                searchResult = realm.objects(Person.self).filter("furigana CONTAINS %@", searchText).sorted(byKeyPath: "furigana")
                print("検索結果：\(searchResult!)")
            }
        }
        tableView.reloadData()
    }
    
    /*
     //MARK: - フィルター機能
     */
    
    let state = UIControl.State.normal
    let OfffilterImage = UIImage(named: "filter1")
    let OnfilterImage = UIImage(named: "filter2")
    
    //TagImages & tag change when btn cricked
    @objc func tagChange(sender: UIButton!){
        
        searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
        
        let genderArray = [maleButton, femaleButton, noGenderButton]
        let heightArray = [longButton, middleButton, shortButton]
        //let otherArray = [glassesButton, hokuroButton, beardButton]
        
        if sender.currentTitle == "男性" || sender.currentTitle == "女性" || sender.currentTitle == "どちらでもない"{
            
            if sender.tag == 1{
                sender.tag = 0
                sender.setBackgroundImage(OfffilterImage, for: state)
            }else{
                //reset btn tag
                for btn in genderArray{
                    btn?.tag = 0
                    btn?.setBackgroundImage(OfffilterImage, for: state)
                }
                sender.tag = 1
                sender.setBackgroundImage(OnfilterImage, for: state)
            }
        }
        
        if sender.currentTitle == "高い" || sender.currentTitle == "普通" || sender.currentTitle == "低い"{
            
            if sender.tag == 1{
                sender.tag = 0
                sender.setBackgroundImage(OfffilterImage, for: state)
            }else{
                //reset btn tag
                for btn in heightArray{
                    btn?.tag = 0
                    btn?.setBackgroundImage(OfffilterImage, for: state)
                }
                sender.tag = 1
                sender.setBackgroundImage(OnfilterImage, for: state)
            }
        }
        
        if sender.currentTitle == "メガネ" || sender.currentTitle == "ほくろ" || sender.currentTitle == "ひげ"{
            
            if sender.tag == 1{
                sender.tag = 0
                sender.setBackgroundImage(OfffilterImage, for: state)
                
            }else{
                sender.tag = 1
                sender.setBackgroundImage(OnfilterImage, for: state)
                
            }
        }
        
        //ここでsearchResultを更新する
        var gender = ""
        var height = ""
        var glasses = false
        var hokuro = false
        var beard = false
            
        var i = 0
            for btn in genderArray{
                
                if btn?.tag == 1{
                    gender = (btn?.currentTitle)!
                    searchResult = realm.objects(Person.self).filter("gender == %@", gender).sorted(byKeyPath: "furigana")
                }else{
                    i += 1
                }
            }
        
        if i == 3{
            searchResult = realm.objects(Person.self).sorted(byKeyPath: "furigana")
        }
        
            i = 0
            for btn in heightArray{
                if btn?.tag == 1{
                    height = (btn?.currentTitle)!
                    searchResult2 = searchResult!.filter("height == %@", height).sorted(byKeyPath: "furigana")
                }else{
                    i += 1
                }
            }
        
        if i == 3{
            searchResult2 = searchResult
        }
            
            
            if glassesButton.tag == 1{
                glasses = true
                searchResult3 = searchResult2!.filter("glasses == %@", glasses).sorted(byKeyPath: "furigana")
            }else{
                searchResult3 = searchResult2
            }
        
        
            if hokuroButton.tag == 1{
                hokuro = true
                searchResult4 = searchResult3!.filter("hokuro == %@", hokuro).sorted(byKeyPath: "furigana")
            }else{
                searchResult4 = searchResult3
            }
        
            if beardButton.tag == 1{
                beard = true
                searchResult = searchResult4!.filter("beard == %@", beard).sorted(byKeyPath: "furigana")
            }else{
                searchResult = searchResult4
            }
            

        
        print("glassees flg:\(glasses)")
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
