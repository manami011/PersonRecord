//
//  TagCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/27.
//

import UIKit
import RealmSwift
import TagListView


class TagCreateViewController: UIViewController, TagListViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var tagListView: TagListView!
    
    let realm = try! Realm()
    var person: Person?
    var category: Category?
    var personCategory: PersonCategory?
    
    var categorySearchResult : Results<Category>?
    var personSearchResult : Results<Person>?
    var personCategoryResult : Results<PersonCategory>?
    
    
    var image: UIImage!
    
    //タグ関連
    var alertTextField: UITextField?
    let MARGIN: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        // Do any additional setup after loading the view.
        personSearchResult = realm.objects(Person.self)
        personCategoryResult = realm.objects(PersonCategory.self)
        categorySearchResult = realm.objects(Category.self)
        
        setUpfaceCreateView()
        
        tagListView.delegate = self
        
        TagListView.CustomTagListView(tagListView: tagListView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SetTag()
        FaceImageLoad()
    }
    
    
    
    //DetailVCから遷移してきた用の値セット
    func SetTag(){
        
        //タグを全て消去
        tagListView.removeAllTags()
        
        
        //カテゴリーのデータが存在したら
        if self.person!.personCategory.count != 0{
            
            
            //現在のpersonのpersonCategoryに絞り込む
            let personResult = realm.objects(PersonCategory.self).filter("person.id == %@", self.person!.id)
            
            
            for allCategory in self.categorySearchResult!{
                
                //全てのカテゴリータグを作る
                let tagView = self.tagListView.addTag(allCategory.categoryName)
                tagView.tagBackgroundColor = UIColor.white
                tagView.isSelected = false
                tagView.onTap = {
                    tagView in
                    self.tagPressed(title: allCategory.categoryName, tagView: tagView, sender: self.tagListView, category: allCategory)
                }
                
                for haveCategory in personResult{
                    
                    if haveCategory.category == nil{
                        print("haveCategoryはnilです。")
                        
                    }else if allCategory.categoryName == haveCategory.category?.categoryName{
                        //personが持っているタグのフラグを変える
                        //色付きタグにする
                        
                        tagView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
                        tagView.isSelected = true
                        print("DEBUG_PRINT:持ってるカテゴリー：\(allCategory.categoryName)")
                        
                    }
                }
            }
        }else{
            for allCategory in self.categorySearchResult!{
                
                //全てのカテゴリータグを作る
                let tagView = self.tagListView.addTag(allCategory.categoryName)
                tagView.tagBackgroundColor = UIColor.white
                tagView.isSelected = false
                tagView.onTap = {
                    tagView in
                    self.tagPressed(title: allCategory.categoryName, tagView: tagView, sender: self.tagListView, category: allCategory)
                }
            }
        }
    }
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        
        let state = UIControl.State.normal
        nameButton.setTitle(person!.name, for: state)
        personImage.image = image
    }
    
    func FaceImageLoad(){
        //PersonImageのパス読み込み
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        //URL型にキャスト
        let fileURL = URL(string: documentPath + "/" + person!.faceImageFilepath)
        //パス型に変換
        if let filePath = fileURL?.path{
            personImage.image = UIImage(contentsOfFile: filePath)
            print("DEBUG_PRINT:filePath:\(String(describing: filePath))")
        }
    }
    
    
    
    //タグを作成
    @IBAction func TagCreate(_ sender: Any) {
        
        let alert = UIAlertController(
            title: "タグ",
            message: "タグ名を入力してください。",
            preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                
                self.alertTextField = textField
                
            })
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.cancel,
                handler: nil))
        alert.addAction(
            UIAlertAction(
                title: "保存",
                style: UIAlertAction.Style.default) { _ in
                if let text = self.alertTextField?.text {
                    
                    let category = Category()
                    let personCategory = PersonCategory()
                    
                    let allCategory = self.realm.objects(Category.self)
                    if allCategory.count != 0{
                        category.id = allCategory.max(ofProperty: "id")! + 1
                    }
                    print("DEBUG_PRINT:人物作成：allCategory:\(allCategory.count)")
                    
                    let realm = try! Realm()
                    
                    try! realm.write(){
                        
                        personCategory.category = category
                        personCategory.person = self.person
                        category.categoryName = text
                        
                        category.personCategory.append(personCategory)
                        self.person!.personCategory.append(personCategory)
                        
                        realm.add(category)
                        realm.add(self.person!)
                    }
                    
                    //タグリスト作成
                    let tagView = self.tagListView.addTag(text)
                    tagView.isSelected = true
                    tagView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
                    tagView.onTap = {
                        tagView in
                        self.tagPressed(title: text, tagView: tagView, sender: self.tagListView, category: category)
                    }
                }
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //タグがタップされた時の挙動
    private func tagPressed(title: String, tagView: TagView, sender: TagListView, category: Category) {
        print("Tag pressed: \(title), \(sender)")
        
        tagView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
        personCategoryResult = realm.objects(PersonCategory.self)
        
        
        if tagView.isSelected == false{
            //非選択状態の挙動
            tagView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
            tagView.isSelected = true
            
            try! realm.write(){
                
                let personCategory = PersonCategory()
                personCategory.person = self.person
                personCategory.category = category
                category.categoryName = title
                
                category.personCategory.append(personCategory)
                self.person!.personCategory.append(personCategory)
                
                realm.add(category)
                realm.add(self.person!)
                
            }
            print("選択されました")
            
        }else{
            //選択状態の挙動
            tagView.tagBackgroundColor = UIColor.white
            tagView.isSelected = false
            
            for personCategory in self.person!.personCategory{
                
                print("DEBUG_PRINT:\(String(describing: personCategory))")
                
                if personCategory.category?.categoryName == title{
                    
                    print("DEBUG_PRINT:このカテゴリーを選択解除します！：「\(String(describing: personCategory.category?.categoryName))」")
                    
                    try! realm.write(){
                        realm.delete(personCategory)
                    }
                }
            }
            print("選択が解除されました")
        }
    }
    
    
    
    
    // タグ削除ボタンが押された
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        // リストからタグ削除
        sender.removeTagView(tagView)
        
        try! realm.write(){
            
            let deleteCategory = realm.objects(Category.self).filter("categoryName == %@", title).first
            
            realm.delete(deleteCategory!.personCategory)
            realm.delete(realm.objects(Category.self).filter("categoryName == %@", title))
        }
        
        print("delete後のデータ：カテゴリー:\(String(describing: categorySearchResult))")
        print("delete後のデータ：人物：\(String(describing: personSearchResult))")
    }
    
    
    
}
