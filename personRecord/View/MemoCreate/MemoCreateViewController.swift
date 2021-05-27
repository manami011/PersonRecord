//
//  MemoCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift
import TagListView

class MemoCreateViewController: UIViewController, UITextFieldDelegate{
    
    let MARGIN: CGFloat = 10
    
    var image: UIImage!
   

    @IBOutlet weak var memoView: MemoView!
    @IBOutlet weak var memo1TextField: UITextField!
    @IBOutlet weak var memo2TextView: UITextView!
    
    
    var person: Person?
    var category: Category?
    var personCategory: PersonCategory?
    let realm = try! Realm()
    
    var categorySearchResult : Results<Category>?
    
    var alertTextField: UITextField?
    
    var isSelected: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        setUpfaceCreateView()
        
        //TextViewカスタマイズ
        UITextField.CustomTextField(textField: memo1TextField)
        UITextView.CustomTextView(textView: memo2TextView)
        
        categorySearchResult = realm.objects(Category.self)
        setTextField()
    }
    
    //DetailVCから遷移してきた時用に値をセットする
    func setTextField(){
        
        if self.person!.memo1 != "" || self.person!.memo2 != ""{
            
            memo1TextField.text = self.person!.memo1
            memo2TextView.text = self.person!.memo2
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
        
        memoView.saveButton.addTarget(self, action: #selector(saveMemo), for: UIControl.Event.touchUpInside)
        
    }
    
    //subviewのレイアウトが完了した際に呼ばれるメソッド
    override func viewDidLayoutSubviews(){
        //PreCreateTagLabel()
    }
    
    override func viewWillLayoutSubviews(){
        //画面のサイズ変更をするときはここに書く
        //PreCreateTagLabel()
    }
 
    
    
    @objc func saveMemo() {
        
        print("メモ内容：メモ１：「\(memo1TextField.text!)」メモ２：「\(memo2TextView.text!)」")
        try! realm.write{
            
            person!.memo1 = memo1TextField.text!
            person!.memo2 = memo2TextView.text!
            
            personCategory?.person = self.person
            self.realm.add(self.person!, update: .modified)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
  
    
//
//    //半透明のボタンをタップするとpersonCategoryにcategoryを追加する
//
//    @objc func tagEvent(_ sender: UIButton){
//
//
//        let button = (sender as UIButton)
//        let text = sender.currentTitle
//        print("DEBUG_PRINT:customViewがタップされました！\(String(describing: text))")
//
//        //フラグがtrue=選択済みのものを再度タップされたら
//        if isSelected {
//            let image = UIImage(named: "UI15")
//            let state = UIControl.State.normal
//            button.setImage(image, for: state)
//
//            //Realmから削除
//        }else{
//            isSelected = true
//            let image = UIImage(named: "UI16")
//            let state = UIControl.State.normal
//            button.setImage(image, for: state)
//            //Realmに追加
//        }
//
//        //deleteButtonを有効にする
//
//        try! realm.write(){
//
//            personCategory!.category = category
//            category!.categoryName = (sender.titleLabel?.text)!
//            print("\(category!.categoryName)")
//            self.person!.personCategory.append(personCategory!)
//
//            realm.add(personCategory!.self)
//        }
//    }
    
    
//    //タグの削除(deleteButtonをタップ)
//
//    @objc func tapped(_ sender: UIButton){
//
//        //TODO:タグ名の取得->personの所持カテゴリー名と一致するrealmデータを削除
//        //true　false入れ替え？（タグは存在させたい）
//
//
//        try! realm.write(){
//
//            //realm.delete(<#T##object: ObjectBase##ObjectBase#>)
//        }
//        print("タグの削除ボタンがタップされました。")
//    }
    
    /*
     // MARK: - バックアップ
     */
    
    /*
     func addpreEntry(count: Int){
     
     let stack = stackView
     let index = stack!.arrangedSubviews.count
     print("DEBUG_PRINT:stack index:\(index)")
     let addView = stack!.arrangedSubviews[index]
     
     let scroll = scrolleView
     //let offset = CGPoint(x: scroll!.contentOffset.x, y: scroll!.contentOffset.y + addView.frame.size.height)
     
     //let newView = PreCreateTagLabel(count: count)
     //newView.isHidden = false
     //stack!.insertArrangedSubview(newView, at: index)
     
     //UIView.animate(withDuration: 0.25) { () -> Void in
     // newView.isHidden = false
     //scroll!.contentOffset = offset
     
     }
     */
    
    //いるかどうか検証
    /*
     func addEntry(categryName: String){
     
     let stack = stackView
     let index = stack!.arrangedSubviews.count - 1
     print("DEBUG_PRINT:stack index:\(index)")
     let addView = stack!.arrangedSubviews[index]
     
     let scroll = scrolleView
     let offset = CGPoint(x: scroll!.contentOffset.x, y: scroll!.contentOffset.y + addView.frame.size.height)
     
     let newView = CreateTagLabel(categoryname: categryName)
     newView.isHidden = true
     stack!.insertArrangedSubview(newView, at: index)
     
     UIView.animate(withDuration: 0.25) { () -> Void in
     newView.isHidden = false
     scroll!.contentOffset = offset
     }
     }
     */
    
    
    
    //   collectonViewレイアウト
    
    
    /*
     
     /*
     //タグ作成時にタグのカスタムViewを生成する
     func CreateTagLabel(categoryname: String, count: Int){
     
     let customView = LabelView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 150))
     customView.tagText.text = categoryname
     print("DEBUG_PRINT:customView.tagText.text\(String(describing: customView.tagText.text))")
     
     self.view.layoutIfNeeded()
     
     customView.translatesAutoresizingMaskIntoConstraints = false
     self.view.addSubview(customView)
     
     //self.contentView.setNeedsLayout()
     
     //self.contentView.layoutIfNeeded()
     
     scrolleView.contentSize.height += customView.frame.height/4
     
     var customHeight = 0
     customHeight += 80*count
     //customHeight += customHeight
     print("DEBUG_PRINT:customHeigh:\(customHeight)")
     print("DEBUG_PRINT:customView.frame.heigh:\(customView.frame)")
     //let customHeight = 10.0 + customView.frame.height * CGFloat(count)
     
     // customViewの幅は、親ビューの幅の1/2
     customView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
     // customViewの親ビューの高さの1/2
     customView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
     
     // customViewの左端は、addTagButtonの右端から20ptの位置
     customView.leadingAnchor.constraint(equalTo: addTagButton.leadingAnchor, constant: 0.0).isActive = true
     
     // customViewの上端は、addTagButtonの下端から指定
     customView.topAnchor.constraint(equalTo: addTagButton.bottomAnchor, constant: CGFloat(customHeight)).isActive = true
     
     
     //ボタンをタップした時に実行するメソッドを指定
     customView.tagDeleteButton.addTarget(self, action: #selector(self.tapped(_:)), for:.touchUpInside)
     }
     
     */
     
     //collectonView配置
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
     categorySearchResult = realm.objects(Category.self)
     print("DEBUG_PRINT:collectioncellの数\(categorySearchResult!.count )")
     return categorySearchResult!.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) //
     cell.backgroundColor = .red  // セルの色
     
     
     return cell
     }
     
     func collectionViewLayout(){
     
     //super [viewDidLayoutSubviews];
     
     let customHeight = CGFloat(50)
     let customWidth = self.view.frame.width
     
     // customViewの幅は、親ビューの幅の1/2
     //collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
     
     //collectionView.contentSize = CGSize(width: customWidth, height: customHeight)
     
     collectionView.backgroundColor = .lightGray
     // レイアウトを調整
     let layout = UICollectionViewFlowLayout()
     layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
     layout.itemSize = CGSize(width: 150, height: 60)
     layout.minimumLineSpacing = 10
     
     collectionView.collectionViewLayout = layout
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let horizontalSpace : CGFloat = 20
     let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
     return CGSize(width: cellSize, height: cellSize)
     }
     */
    
    /*
     //contentView cellのサイズ変更があったときに呼ばれる
     override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
     guard let cv = collectionView else { return false }
     
     return !newBounds.size.equalTo(cv.bounds.size)
     }
     */
    
}
