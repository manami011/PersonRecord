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
    
    @IBOutlet weak var memoView: MemoView!
    
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
        setUpfaceCreateView()
        
        PreCreateTagLabel()
        
        memoView.saveButton.isHidden = true
        
        tagListView.delegate = self
        
        TagListView.CustomTagListView(tagListView: tagListView)
        personSearchResult = realm.objects(Person.self)
        personCategoryResult = realm.objects(PersonCategory.self)
    }
    
    
    //DetailVCから遷移してきた用の値セット
    func setTag(){
        
        if self.person!.personCategory[0].category != nil{
            
            //現在のpersonのpersonCategoryに絞り込む
            let personResult = realm.objects(PersonCategory.self).filter("person.id == %@", self.person!.id)
            
            for i in 0...personResult.count-1{
                
                
                
            }
            
            
        }
        
    }
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        let nib = UINib(nibName: "MemoView", bundle: nil)
        memoView = nib.instantiate(withOwner: self, options: nil).first as? MemoView
        
        self.view.addSubview(memoView)
        
        let state = UIControl.State.normal
        memoView.nameButton.setTitle(person!.name, for: state)
        memoView.personImage.image = image
    }
    

    
    
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
                        
                        print("personCategory:\(category.personCategory[0])")
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
    
    //今までのCategoryタグを作る
    func PreCreateTagLabel(){
        
        categorySearchResult = realm.objects(Category.self)
        
        if categorySearchResult?.count == 0{
            print("Categoryは０件です")
            return
        }
        
        for count in 0...categorySearchResult!.count-1{
            
            //カテゴリーのデータを取り出してカテゴリータグを生成
            let tagView = self.tagListView.addTag(categorySearchResult![count].categoryName)
            tagView.isSelected = false
            tagView.onTap = {
                tagView in
                self.tagPressed(title: self.categorySearchResult![count].categoryName, tagView: tagView, sender: self.tagListView, category: self.categorySearchResult![count])
            }
        }
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
                personCategory.category = category
                personCategory.person = self.person
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
            
            for i in 0...personCategoryResult!.count-1{
                
                let personCategory = personCategoryResult![i]
                
                if personCategory.person!.id == self.person!.id && personCategory.category?.categoryName == category.categoryName{
                    
                    print("このカテゴリーを削除します！：「\(personCategory)」")
                    
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
            realm.delete(realm.objects(Category.self).filter("categoryName == %@", title))
        }
        
        print("delete後のデータ：カテゴリー:\(String(describing: categorySearchResult))")
        print("delete後のデータ：人物：\(String(describing: personSearchResult))")
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
