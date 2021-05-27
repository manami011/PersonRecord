//
//  FaceCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/12.
//

import UIKit
import RealmSwift

class FaceCreateViewController: UIViewController {
    
    let realm = try! Realm()
    var person: Person?
    var personCategory: PersonCategory?
    
 
    @IBOutlet weak var faceCreateView: FaceCreateView!
    
    //Imageの管理
    var backNumber = 0
    var frontNumber = 0
    var outlineNumber = 0
    var expressionNumber = 0
    
    //色の管理
    var backcolorNumber = 0
    var frontcolorNumber = 0
    var outlinecolorNumber = 0
    var expressioncolorNumber = 0
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色の変更を実行するため、storyboardと非同期処理
        DispatchQueue.main.async {
                   self.view.backgroundColor = UIColor.MyTheme.backgroundColor}
        // Do any additional setup after loading the view.
        
        //faceCreateView準備
        faceViewCreate()
        
        
        if person == nil{
            print("DEBUG_PRINT:personはnilです。")
            return}else{
            print("DEBUG_PRINT name:\(person!.name)")}
    }
    
    //他タブバーからの切り替え時に変更を反映する
    func FaceReLoad(){
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(backcolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(backNumber)\(backcolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(backNumber)\(backcolorNumber)")
        faceCreateView.expression.image = UIImage(named: "e\(backNumber)\(backcolorNumber)")
    }
    
    
    //FaceViewの使用に必要なメソッドをまとめる
    func faceViewCreate(){
        
        setUpfaceCreateView()
        setUpSlider()
    }
    
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        let nib = UINib(nibName: "FaceCreateView", bundle: nil)
        faceCreateView = nib.instantiate(withOwner: self, options: nil).first as? FaceCreateView
        
        self.view.addSubview(faceCreateView)
        
        let state = UIControl.State.normal
        faceCreateView.nameButton.setTitle(person!.name, for: state)
        
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(backcolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.head.image = UIImage(named: "head")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(frontcolorNumber)")
        faceCreateView.expression.image = UIImage(named: "e\(expressionNumber)\(expressioncolorNumber)")
        
        faceCreateView.saveButton.addTarget(self, action: #selector(SaveFace), for: UIControl.Event.touchUpInside)
        
    }
    
    func setUpSlider(){
        //スライダーの割り当て
        faceCreateView.slider1.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        faceCreateView.slider2.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        faceCreateView.slider3.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        
        faceCreateView.slider4.isHidden = true
    }
    
    //スライダーの値を取れるようにする。
    @objc func sliderValue(_sender: UISlider!){
        
        if _sender == faceCreateView.slider1{
            
            frontNumber = Int(faceCreateView.slider1.value)
            faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(frontcolorNumber)")
            
            print("slider1が動いた！")
            
        }else if _sender == faceCreateView.slider2{
            
            backNumber = Int(faceCreateView.slider2.value)
            faceCreateView.front.image = UIImage(named: "b\(backNumber)\(backcolorNumber)")
            
            print("slider2が動いた！")
            
        }else if _sender == faceCreateView.slider3{
            
            outlineNumber = Int(faceCreateView.slider3.value)
            faceCreateView.front.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
            
            print("slider3が動いた！")
            
        }else if _sender == faceCreateView.slider4{
            
            print("slider4が動いた！")
            
        }else{
            print("どのsliderでもありません。")
        }
    }
    
    
    
    //全体を保存
    @objc func SaveFace(_ sender: Any) {
       
        try! realm.write{
            //パーツ番号
            self.person!.backNumber = backNumber
            self.person!.outlineNumber = outlineNumber
            self.person!.frontNumber = frontNumber
            
            //カラー番号
            self.person!.backcolorNumber = backcolorNumber
            self.realm.add(self.person!, update: .modified)
        }
        
        self.personCategory?.person = person
        
        let tagTabBar = self.storyboard!.instantiateViewController(identifier: "tagTab") as! MemoTabBar
        
        let memoVC = tagTabBar.self.viewControllers![0] as! MemoCreateViewController
        let tagVC = tagTabBar.self.viewControllers![1] as! TagCreateViewController
        
        memoVC.person = person
        memoVC.personCategory = personCategory
        memoVC.image = CompositeIgame()
        
        tagVC.person = person
        tagVC.personCategory = personCategory
        tagVC.image = CompositeIgame()
        
        UIImage.ImagefileSave(person: person!, faceImage: memoVC.image)
        print("DEBUG_PRINT:テスト")
        
        self.navigationItem.hidesBackButton = true
        self.navigationController!.pushViewController(tagTabBar, animated: true)
    }
    
    //画像を合成する
    func CompositeIgame() -> UIImage {
      
        let composedImage = UIImage.ComposeUIImage(UIImageArray: ResizeÜIImage(), width: 280, height: 330)
        return composedImage!
    }
    
    func ResizeÜIImage() -> [UIImage]{
        
        let backImage = UIImage(named: "b\(backNumber)\(backcolorNumber)")!
        let outlineImage = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")!
        let frontImage = UIImage(named: "f\(frontNumber)\(frontcolorNumber)")!
        let expressionImage = UIImage(named: "e\(expressionNumber)\(expressioncolorNumber)")!
        let headImage = UIImage(named: "head")!
        
        let newbackImage = UIImage.ResizeÜIImage(image:backImage, width: 250, height: 300)
        let newoutlineImage = UIImage.ResizeÜIImage(image:outlineImage, width: 250, height: 300)
        let newheadImage = UIImage.ResizeÜIImage(image:headImage, width: 250, height: 300)
        let newfrontImage = UIImage.ResizeÜIImage(image:frontImage, width: 250, height: 300)
        let newexpressionImage = UIImage.ResizeÜIImage(image:expressionImage, width: 250, height: 300)
        
        return [newbackImage!, newheadImage!, newoutlineImage!, newfrontImage!, newexpressionImage!]
    }
  
}
