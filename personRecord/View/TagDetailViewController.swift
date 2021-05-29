//
//  TagDetailViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/21.
//

import UIKit
import RealmSwift

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
        
        print("category!.categoryName:\(category!.categoryName)")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categorySearchResult = realm.objects(Category.self)
        personSearchResult = realm.objects(Person.self)
    }
    
    //セルのタップイベント
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = self.category?.personCategory[indexPath.row].person!
        
        let detailVC = self.storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        detailVC.person = person
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = category!.personCategory.count
        print("DEBUG_PRINT:Personcount\(count)")
        return count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let person = self.category?.personCategory[indexPath.row].person!
        
        //PersonImageのパス読み込み
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        //URL型にキャスト
        let fileURL = URL(string: documentPath + "/" + person!.faceImageFilepath)
        
        let filePath = fileURL?.path
        
        let state = UIControl.State.normal
        
        cell.name.titleLabel?.numberOfLines = 0
        cell.name.setTitle(person!.name, for: state)
        cell.personImage.image = UIImage(contentsOfFile: filePath!)
        
        print("filePath:\(String(describing: filePath))")
        
        return cell
    }
    
    
    //コレクションビューのレイアウト
    func collectionViewLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 250)
        
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
