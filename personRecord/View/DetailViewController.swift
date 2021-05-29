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
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var tagListView: TagListView!
    
    
    let realm = try! Realm()
    var person: Person?
    var searchResult : Results<Person>?
    
    let MARGIN: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("print(person) \(String(describing: person!.name))")
        
        tagListView.delegate = self
        
        updateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        tagListView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
        
        updateLayout()
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
    
    //登録してあるCategoryタグを作る
    func PreCreateTagLabel(){
        
        
        
        if self.person!.personCategory.count == 0{
            print("Categoryは０件です")
            return
        }
        
        for count in 0...person!.personCategory.count-1{
            
            if self.person!.personCategory[count].category != nil{
                //カテゴリーのデータを取り出してカテゴリータグを生成
                let tagView = self.tagListView.addTag(self.person!.personCategory[count].category!.categoryName)
                tagView.isSelected = false
                
            }else{
                //カテゴリーが別のところで削除された場合、.person.personCategory.categoryが nilになる
                print("削除されたカテゴリーが含まれています")
            }
        }
    }
    
    
    //Viewのサイズを調整する
    func updateLayout(){
        
        // タグ全体の高さを取得
        tagListView.frame.size = tagListView.intrinsicContentSize
        
        //メモラベルの高さを取得
        let memo1height = memo1Label.frame.size.height
        let memo2height = memo2Label.frame.size.height
        //let orijinheight = self.view.frame.size.height
        //let orijinwidth = self.view.frame.size.width
        
        
        contentView.frame.size.height = 850
        let contentHeight = contentView.frame.size.height + memo1height + memo2height
        scrollView.contentSize = CGSize(width: scrollView.frame.width , height: contentHeight)
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
