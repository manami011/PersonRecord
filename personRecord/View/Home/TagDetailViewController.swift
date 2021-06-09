//
//  TagDetailViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit
import RealmSwift
import MBProgressHUD
import SVProgressHUD

class TagDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var categoryLabel: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var person: Person?
    var category: Category?
    
    var categorySearchResult : Results<Category>?
    var personSearchResult : Results<Person>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        // Do any additional setup after loading the view.
        
        self.view.bringSubviewToFront(categoryName)
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        collectionView.collectionViewLayout = collectionViewLayout()
        
        categoryName.text = category!.categoryName
        
        categoryLabel.transform = CGAffineTransform(rotationAngle: -(.pi / 16))
        categoryName.transform = CGAffineTransform(rotationAngle: -(.pi / 16))
        
        print("TagDetailViewController:category!.categoryName:\(category!.categoryName)")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categorySearchResult = realm.objects(Category.self)
        personSearchResult = realm.objects(Person.self)
    }
    
    //セルのタップイベント
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG_PRINT:セルに表示するpersonはこの人です！\(self.category?.personCategory[indexPath.row].person!.name)")
      
        if let person = self.category!.personCategory[indexPath.row].person{
            
            print("DEBUG_PRINT:personはこちら\(person)")
            let detailVC = self.storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
            detailVC.person = person
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }else{
            return
        }
        
        
    }
    
    // 表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        
        if category!.personCategory.count != 0{
            
            for i in 0...category!.personCategory.count-1{
                
                if category!.personCategory[i].person != nil {
                    count += 1
                }
            }
        }else{
            //HUDでありません！
            SVProgressHUD.showError(withStatus: "このタグに登録されている人はいません！")
        }
       
        
        //let count = category!.personCategory.count
        print("DEBUG_PRINT:Personcount\(count)")
        return count
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if let person = self.category?.personCategory[indexPath.row].person{
            
            //PersonImageのパス読み込み
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
            //URL型にキャスト
            let fileURL = URL(string: documentPath + "/" + person.faceImageFilepath)
            
            print("faceImageFilepath:\(person.faceImageFilepath)")
            print("documentPath:\(documentPath)")
            print("fileURL:\(String(describing: fileURL))")
            
            let filePath = fileURL?.path
            
            let state = UIControl.State.normal
            
            cell.name.titleLabel?.numberOfLines = 0
            cell.name.setTitle(person.name, for: state)
            
            if let filePath = filePath{
                cell.personImage.image = UIImage(contentsOfFile: filePath)
            }
            print("filePath:\(String(describing: filePath))")
            
        }
        
        return cell
    }
    
    
    //コレクションビューのレイアウト
    func collectionViewLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 220)
        
        return layout
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
