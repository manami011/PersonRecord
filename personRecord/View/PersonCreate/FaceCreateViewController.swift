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
    
    weak var delegate: Mochi?
    
    @IBOutlet weak var faceCreateView: FaceCreateView!
    
    //Imageの管理----------------
    //髪、輪郭
    var backNumber = 0
    var frontNumber = 0
    var outlineNumber = 0
    
    //目、眉毛,口
    var eyeNumber = 0
    var eyebrowsNumber = 0
    var mouthNumber = 0
    
    //ひげ,メガネ,ほくろ
    var beardNumber = 0
    var glassesNumber = 0
    var hokuroNumber = 0
    
    
    //色の管理（色が変えられるもの）-------------------
    
    //髪の毛、肌
    var haircolorNumber = 2
    var outlinecolorNumber = 0
    
    //眉毛
    var eyebrowscolorNumber = 0
    
    //ひげ、メガネ
    var beardcolorNumber = 0
    var glassescolorNumber = 0
 
    //-----------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色の変更を実行するため、storyboardと非同期処理
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.MyTheme.backgroundColor}
        // Do any additional setup after loading the view.
        
        //faceCreateView準備
        faceViewCreate()
        print("3髪型画像：\(faceCreateView.back.image) ")
       if faceCreateView == nil{
            print("DEBUG_PRINT:faceCreateViewはnilです。")
            return}else{
            print("DEBUG_PRINT faceCreateViewはあります")}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("3髪の色：\(haircolorNumber)・髪型：\(backNumber)")
        FaceReLoad()
        print("2髪の色：\(haircolorNumber)・髪型：\(backNumber)")
        print("2髪型画像：\(faceCreateView.back.image)")
    }
    
    //他タブバーからの切り替え時に変更を反映する
    @objc func FaceReLoad(){
        
        if faceCreateView == nil{
            print("faceCreateViewはnilです")
            return
        }
        print("DEBUG_PRINT:face1.backImage\(String(describing: faceCreateView.back.image) )")
        
        //前髪、輪郭、後ろ髪
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
        
        //目、眉毛、口（表情）
        faceCreateView.eye.image = UIImage(named: "eye\(eyeNumber)")
        faceCreateView.eyebrows.image = UIImage(named: "eb\(eyebrowsNumber)")
        faceCreateView.mouth.image = UIImage(named: "m\(mouthNumber)")
        print("mouthNumber:\(mouthNumber)")
        
        //ひげ、ほくろ、メガネ
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
        
        print("DEBUG_PRINT:face1.haircolorNumber:\(haircolorNumber)")
    }
    
    
    //FaceViewの使用に必要なメソッドをまとめる
    func faceViewCreate(){
        
        setUpfaceCreateView()
        setUpSlider()
        
        //backNumber = self.person!.backNumber
        print("FaceCreate()")
    }
    
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        let nib = UINib(nibName: "FaceCreateView", bundle: nil)
        faceCreateView = nib.instantiate(withOwner: self, options: nil).first as? FaceCreateView
        
        self.view.addSubview(faceCreateView)
        
        let state = UIControl.State.normal
        faceCreateView.nameButton.setTitle(person!.name, for: state)
        
        backNumber = self.person!.backNumber
        frontNumber = self.person!.frontNumber
        haircolorNumber = self.person!.haircolorNumber
        
        
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
        
        print("1髪の色：\(String(describing: self.person?.haircolorNumber))・髪型：\(String(describing: self.person?.backNumber))")
        print("1髪型画像：\(String(describing: faceCreateView.back.image)) ")
        
        //目、眉毛、口（表情）
        faceCreateView.eye.image = UIImage(named: "eye\(eyeNumber)")
        faceCreateView.eyebrows.image = UIImage(named: "eb\(eyebrowsNumber)")
        faceCreateView.mouth.image = UIImage(named: "m\(mouthNumber)")
        
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
        
        faceCreateView.icon1Image.image = UIImage(named: "icon1")
        faceCreateView.icon2Image.image = UIImage(named: "icon2")
        faceCreateView.icon3Image.image = UIImage(named: "icon3")
        faceCreateView.icon4Image.isHidden = true
        
        faceCreateView.saveButton.addTarget(self, action: #selector(SaveFace), for: UIControl.Event.touchUpInside)
        
    }
    
    func setUpSlider(){
        //スライダーの割り当て
        //前髪
        faceCreateView.slider1.maximumValue = 4
        faceCreateView.slider1.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //後ろ髪
        faceCreateView.slider2.maximumValue = 4
        faceCreateView.slider2.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //輪郭
        faceCreateView.slider3.maximumValue = 5
        faceCreateView.slider3.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        
        faceCreateView.slider4.isHidden = true
    }
    
    //スライダーの値を取れるようにする。
    @objc func sliderValue(_sender: UISlider!){
        
        if _sender == faceCreateView.slider1{
            //前髪
            frontNumber = Int(faceCreateView.slider1.value)
            faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
            
            print("slider1が動いた！")
            
        }else if _sender == faceCreateView.slider2{
            //後ろ髪
            backNumber = Int(faceCreateView.slider2.value)
            faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
            
            print("slider2が動いた！")
            
        }else if _sender == faceCreateView.slider3{
            //輪郭
            outlineNumber = Int(faceCreateView.slider3.value)
            faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
            
            print("slider3が動いた！")
            
        }else if _sender == faceCreateView.slider4{
            
            print("slider4が動いた！")
            
        }
        sliderMove()
    }
    
    func sliderMove(){
        
        print("face4.sliderMove呼ばれた")
        return self.delegate!.sliderMove(back: backNumber, front: frontNumber, outline: outlineNumber, eye:eyeNumber, eyebrows:eyebrowsNumber, mouth:mouthNumber, glasses: glassesNumber, hokuro: hokuroNumber, beard: beardNumber, haircolor: haircolorNumber, outlinecolor: outlinecolorNumber, glassescolor: glassescolorNumber, beardcolor: beardcolorNumber)
       }
    
    
    
    
    
    //全体を保存
    @objc func SaveFace(_ sender: Any) {
       
        try! realm.write{
            //パーツ番号
            self.person!.backNumber = backNumber
            self.person!.outlineNumber = outlineNumber
            self.person!.frontNumber = frontNumber
            
            self.person!.eyeNumber = eyeNumber
            self.person!.eyebrowsNumber = eyebrowsNumber
            self.person!.mouthNumber = mouthNumber
            
            self.person!.beardNumber = beardNumber
            self.person!.glassesNumber = glassesNumber
            self.person!.hokuroNumber = hokuroNumber
            
            //カラー番号
            self.person!.haircolorNumber = haircolorNumber
            self.person!.beardcolorNumber = beardcolorNumber
            self.person!.glassescolorNumber = glassesNumber
            
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
      
        let composedImage = UIImage.ComposeUIImage(UIImageArray: ResizeÜIImage(), width: 215, height: 247)
        return composedImage!
    }
    
    func ResizeÜIImage() -> [UIImage]{
        
        let backImage = UIImage(named: "b\(backNumber)\(haircolorNumber)")!
        let outlineImage = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")!
        let frontImage = UIImage(named: "f\(frontNumber)\(haircolorNumber)")!
        
        let eyeImage = UIImage(named: "eye\(eyeNumber)")!
        let eyebrowsImage = UIImage(named: "eb\(eyebrowsNumber)")!
        let mouthImage = UIImage(named: "m\(mouthNumber)")!
        
        let beardImage = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")!
        let glassesImage = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")!
        let hokuroImage = UIImage(named: "h\(hokuroNumber)")!
        
        let width = 215
        let height = 247
        
        
        let newbackImage = UIImage.ResizeÜIImage(image:backImage, width: CGFloat(width), height: CGFloat(height))
        let newoutlineImage = UIImage.ResizeÜIImage(image:outlineImage, width: CGFloat(width), height: CGFloat(height))
        
        let newfrontImage = UIImage.ResizeÜIImage(image:frontImage, width: CGFloat(width), height: CGFloat(height))
        
        let neweyeImage = UIImage.ResizeÜIImage(image:eyeImage, width: CGFloat(width), height: CGFloat(height))
        let neweyebrowsImage = UIImage.ResizeÜIImage(image:eyebrowsImage, width: CGFloat(width), height: CGFloat(height))
        let newmouthImage = UIImage.ResizeÜIImage(image:mouthImage, width: CGFloat(width), height: CGFloat(height))
        
        
        let newbeardImage = UIImage.ResizeÜIImage(image:beardImage, width: CGFloat(width), height: CGFloat(height))
        let newglassesImage = UIImage.ResizeÜIImage(image:glassesImage, width: CGFloat(width), height: CGFloat(height))
        let newhokuroImage = UIImage.ResizeÜIImage(image:hokuroImage, width: CGFloat(width), height: CGFloat(height))
        
        return [newbackImage!, newoutlineImage!, newfrontImage!, neweyeImage!, neweyebrowsImage!, newmouthImage!, newbeardImage!, newglassesImage!, newhokuroImage!]
    }
  
}
