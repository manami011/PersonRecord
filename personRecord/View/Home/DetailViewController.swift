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
    
    @IBOutlet weak var title2Label: UILabel!
    
    //フィルター表示
    @IBOutlet weak var genderLabel: UIButton!
    @IBOutlet weak var heightLabel: UIButton!
    @IBOutlet weak var glassesLabel: UIButton!
    
    @IBOutlet weak var threestackView: UIStackView!
    
    //メモ内容
    @IBOutlet weak var memoLabel: PaddingLabel!
    
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
        
        FaceImageLoad()
        memoLabel.text = person!.memo
        
        
        let state = UIControl.State.normal
        nameButton.setTitle(person!.name, for: state)
        PaddingLabel.CustomUILabel(label: memoLabel)
        
        PreCreateTagLabel()
        TagListView.CustomTagListView(tagListView: tagListView)
        // タグの削除ボタンを有効に
        tagListView.enableRemoveButton = false
        tagListView.tagBackgroundColor = UIColor.MyTheme.tabBarColor
        
        CreateFilterLabel()
    }
    
    func CreateFilterLabel(){
        
        
        genderLabel.setTitle(person?.gender, for: UIControl.State.normal)
        heightLabel.setTitle(person?.height, for: UIControl.State.normal)
        
        let personfilters = [
             "メガネ" : person?.glasses,
             "ほくろ" : person?.hokuro,
             "ひげ" : person?.beard
        ]
        
        var xposition = 0
        for filter in personfilters{
            
            
            if filter.value == true{
                print("キー\(filter.key),value:\(filter.value)")
                let btn = UIButton()
                let image = UIImage(named: "filter1")
                btn.setBackgroundImage(image, for: UIControl.State.normal)
                btn.setTitle("\(filter.key)", for: UIControl.State.normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                
                xposition += 80
                print("xposition:\(xposition)")
                btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
                btn.frame = CGRect(x: xposition, y: 0, width: 80, height: 30)
                threestackView.addSubview(btn)
                self.view.bringSubviewToFront(threestackView)
            }
            
        }
        
        
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
        
        //タグを全て消去
        tagListView.removeAllTags()
        
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
    
 
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
