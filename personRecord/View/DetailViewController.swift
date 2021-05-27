//
//  DetailViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift
import TagListView

class DetailViewController: UIViewController, TagListViewDelegate {
    
    //似顔絵
    @IBOutlet weak var personImage: UIImageView!
    
    //項目名ラベル
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    
    //メモ内容
    @IBOutlet weak var memo1Label: UILabel!
    @IBOutlet weak var memo2Label: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tagListView: TagListView!
    
    
    let realm = try! Realm()
    var person: Person?
    var searchResult : Results<Person>?
    
    let MARGIN: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("print(person) \(String(describing: person))")
        
        tagListView.delegate = self
        
        setUpView()
    }
    
    
    @IBAction func EditingPerson(_ sender: Any) {
        
        let tagTab = self.storyboard?.instantiateViewController(identifier: "tagTab") as! MemoTabBar
        let memoVC = tagTab.self.viewControllers![0] as! MemoCreateViewController
        let tagVC = tagTab.self.viewControllers![1] as! TagCreateViewController
        
        memoVC.person = self.person
        tagVC.person = self.person
        
        tagTab.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(tagTab, animated: true)
    }
    
    //表示内容セット
    func setUpView(){
        
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        //title1Label.backgroundColor = UIColor.MyTheme.labelColor
        FaceImageLoad()
        memo1Label.text = person!.memo1
        memo2Label.text = person!.memo2
        
        let state = UIControl.State.normal
        nameButton.setTitle(person!.name, for: state)
        UILabel.CustomUILabel(label: memo1Label)
        UILabel.CustomUILabel(label: memo2Label)
        PreCreateTagLabel()
        TagListView.CustomTagListView(tagListView: tagListView)
        // タグの削除ボタンを有効に
        tagListView.enableRemoveButton = false
    }
    
    
    
    func FaceImageLoad(){
        //PersonImageのパス読み込み
        //URL型にキャスト
        let fileURL = URL(string: person!.faceImageFilepath)
        //パス型に変換
        let filePath = fileURL?.path
        personImage.image = UIImage(contentsOfFile: filePath!)
        
        print("DEBUG_PRINT:filePath:\(String(describing: filePath))")
    }
    
    //今までのCategoryタグを作る
    func PreCreateTagLabel(){
        
        if self.person!.personCategory.count == 0{
            print("Categoryは０件です")
            return
        }
        
        for count in 0...person!.personCategory.count-1{
            
            //カテゴリーのデータを取り出してカテゴリータグを生成
            let tagView = self.tagListView.addTag(self.person!.personCategory[count].category!.categoryName)
            tagView.isSelected = false
            
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
