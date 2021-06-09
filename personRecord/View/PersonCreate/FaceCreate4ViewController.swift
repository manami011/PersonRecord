//
//  FaceCreate4ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/20.
//

import UIKit
import RealmSwift

//色
class FaceCreate4ViewController: UIViewController {
    
    var person: Person?
    var personCategory: PersonCategory?
    let realm = try! Realm()
    
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
    var haircolorNumber = 0
    var outlinecolorNumber = 0
    
    //眉毛
    var eyebrowscolorNumber = 0
    
    //ひげ、メガネ
    var beardcolorNumber = 0
    var glassescolorNumber = 0
    
    //-----------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        //背景色の変更を実行するため、storyboardと非同期処理
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.MyTheme.backgroundColor
        }
        faceViewCreate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FaceReLoad()
    }
    
    //FaceViewの使用に必要なメソッドをまとめる
    func faceViewCreate(){
        
        setUpfaceCreateView()
        setUpSlider()
    }
    
    
    //他タブバーからの切り替え時に変更を反映する
    @objc func FaceReLoad(){
        
        if faceCreateView == nil{
            print("faceCreateViewはnilです")
            return
        }
        
        print("DEBUG_PRINT:face4.backimage:\(String(describing: faceCreateView.back.image) )")
        
        
        
        //前髪、輪郭、後ろ髪
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
        
        //目、眉毛、口（表情）
        faceCreateView.eye.image = UIImage(named: "eye\(eyeNumber)")
        faceCreateView.eyebrows.image = UIImage(named: "eb\(eyebrowsNumber)")
        faceCreateView.mouth.image = UIImage(named: "m\(mouthNumber)")
        
        //ひげ、ほくろ、メガネ
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
    }
    
    
    func setUpSlider(){
        //スライダーの割り当て
        //髪の色
        faceCreateView.slider1.maximumValue = 5
        faceCreateView.slider1.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //目の色
        faceCreateView.slider2.maximumValue = 1
        faceCreateView.slider2.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //ひげの色
        faceCreateView.slider3.maximumValue = 1
        faceCreateView.slider3.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //肌の色
        faceCreateView.slider4.maximumValue = 4
        faceCreateView.slider4.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
    }
    
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        let nib = UINib(nibName: "FaceCreateView", bundle: nil)
        faceCreateView = nib.instantiate(withOwner: self, options: nil).first as? FaceCreateView
        
        self.view.addSubview(faceCreateView)
        
        let state = UIControl.State.normal
        faceCreateView.nameButton.setTitle(person!.name, for: state)
        
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
        
        //目、眉毛、口（表情）
        faceCreateView.eye.image = UIImage(named: "eye\(eyeNumber)")
        faceCreateView.eyebrows.image = UIImage(named: "eb\(eyebrowsNumber)")
        faceCreateView.mouth.image = UIImage(named: "m\(mouthNumber)")
        print("mouthNumber:\(mouthNumber)")
        
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
        
        faceCreateView.icon1Image.image = UIImage(named: "icon10")
        faceCreateView.icon2Image.image = UIImage(named: "icon14")
        faceCreateView.icon3Image.image = UIImage(named: "icon12")
        faceCreateView.icon4Image.image = UIImage(named: "icon13")
        faceCreateView.icon4Image.isHidden = false
        
        faceCreateView.saveButton.addTarget(self, action: #selector(SaveFace), for: UIControl.Event.touchUpInside)
        
    }
    
    //スライダーのつまみを動かした時に呼ばれる
    @objc func sliderValue(_sender: UISlider!){
        
        if _sender == faceCreateView.slider1{
            //髪の色
            haircolorNumber = Int(faceCreateView.slider1.value)
            faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
            faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
            
            
            
        }else if _sender == faceCreateView.slider2{
            //目の色
            
            
            
        }else if _sender == faceCreateView.slider3{
            
            
            
            
        }else if _sender == faceCreateView.slider4{
            //肌の色
            outlinecolorNumber = Int(faceCreateView.slider4.value)
            faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
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
        
        
        let newbackImage = UIImage.ResizeÜIImage(image:backImage, width: 250, height: 300)
        let newoutlineImage = UIImage.ResizeÜIImage(image:outlineImage, width: 250, height: 300)
        
        let newfrontImage = UIImage.ResizeÜIImage(image:frontImage, width: 250, height: 300)
        
        let neweyeImage = UIImage.ResizeÜIImage(image:eyeImage, width: 250, height: 300)
        let neweyebrowsImage = UIImage.ResizeÜIImage(image:eyebrowsImage, width: 250, height: 300)
        let newmouthImage = UIImage.ResizeÜIImage(image:mouthImage, width: 250, height: 300)
        
        let newbeardImage = UIImage.ResizeÜIImage(image:beardImage, width: 250, height: 300)
        let newglassesImage = UIImage.ResizeÜIImage(image:glassesImage, width: 250, height: 300)
        let newhokuroImage = UIImage.ResizeÜIImage(image:hokuroImage, width: 250, height: 300)
        
        return [newbackImage!, newoutlineImage!, newfrontImage!, neweyeImage!, neweyebrowsImage!, newmouthImage!, newbeardImage!, newglassesImage!, newhokuroImage!]
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
