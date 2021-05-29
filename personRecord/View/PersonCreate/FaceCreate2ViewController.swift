//
//  FaceCreate2ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/19.
//

import UIKit
import RealmSwift

//眉毛、口
class FaceCreate2ViewController: UIViewController {

    let realm = try! Realm()
    var person: Person?
    var personCategory: PersonCategory?
    
    weak var delegate: Mochi?
    
    @IBOutlet weak var faceCreateView: FaceCreateView!
    
    var image1:UIImage!
    var image2:UIImage!
    var image3:UIImage!
    
    //Imageの管理----------------
    //髪、輪郭
    var backNumber = 0
    var frontNumber = 0
    var outlineNumber = 0
    
    var expressionNumber = 0
    
    //眉毛,口
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
        print("DEBUG_PRINT:\(String(describing: faceCreateView.back.image) )")
        
        print("DEBUG_PRINT:haircolorNumber:\(haircolorNumber)")
        
        //前髪、輪郭、後ろ髪
        faceCreateView.back.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
        faceCreateView.outline.image = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")
        faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
        
        //眉毛、口（表情）
        faceCreateView.expression.image = UIImage(named: "e\(expressionNumber)")
        
        //ひげ、ほくろ、メガネ
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
    }
    
    
    func setUpSlider(){
        //スライダーの割り当て
        //眉毛
        faceCreateView.slider1.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //目
        faceCreateView.slider2.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        //口
        faceCreateView.slider3.addTarget(self, action: #selector(sliderValue(_sender:)), for: .valueChanged)
        
        faceCreateView.slider4.isHidden = true
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
        faceCreateView.expression.image = UIImage(named: "e\(expressionNumber)")
        
        faceCreateView.glasses.image = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")
        faceCreateView.beard.image = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")
        faceCreateView.hokuro.image = UIImage(named: "h\(hokuroNumber)")
        
        faceCreateView.saveButton.addTarget(self, action: #selector(SaveFace), for: UIControl.Event.touchUpInside)
        
    }
    
    //スライダーの値を取れるようにする。
    @objc func sliderValue(_sender: UISlider!){
        
        if _sender == faceCreateView.slider1{
            //眉毛
            //frontNumber = Int(faceCreateView.slider1.value)
            //faceCreateView.front.image = UIImage(named: "f\(frontNumber)\(haircolorNumber)")
            
            print("slider1が動いた！")
            
        }else if _sender == faceCreateView.slider2{
            //目
            //backNumber = Int(faceCreateView.slider2.value)
            //faceCreateView.front.image = UIImage(named: "b\(backNumber)\(haircolorNumber)")
            
            print("slider2が動いた！")
            
        }else if _sender == faceCreateView.slider3{
            //口
            //outlineNumber = Int(faceCreateView.slider3.value)
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
            
            self.person!.exprassionNumber = expressionNumber
            
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
        
        let memoVC = self.storyboard!.instantiateViewController(identifier: "memo") as! MemoCreateViewController
        
        memoVC.person = person
        memoVC.personCategory = personCategory
        memoVC.image = CompositeIgame()
        
        UIImage.ImagefileSave(person: person!, faceImage: memoVC.image)
        print("DEBUG_PRINT:テスト")
        
        self.navigationController!.pushViewController(memoVC, animated: true)
    }
    
    
    //画像を合成する
    func CompositeIgame() -> UIImage {
      
        let composedImage = UIImage.ComposeUIImage(UIImageArray: ResizeÜIImage(), width: 250, height: 300)
        return composedImage!
    }
    
    func ResizeÜIImage() -> [UIImage]{
        
        let backImage = UIImage(named: "b\(backNumber)\(haircolorNumber)")!
        let outlineImage = UIImage(named: "o\(outlineNumber)\(outlinecolorNumber)")!
        let frontImage = UIImage(named: "f\(frontNumber)\(haircolorNumber)")!
        let expressionImage = UIImage(named: "e\(expressionNumber)")!
        
        let beardImage = UIImage(named: "be\(beardNumber)\(beardcolorNumber)")!
        let glassesImage = UIImage(named: "g\(glassesNumber)\(glassescolorNumber)")!
        let hokuroImage = UIImage(named: "h\(hokuroNumber)")!
        
        
        let newbackImage = UIImage.ResizeÜIImage(image:backImage, width: 250, height: 300)
        let newoutlineImage = UIImage.ResizeÜIImage(image:outlineImage, width: 250, height: 300)
        
        let newfrontImage = UIImage.ResizeÜIImage(image:frontImage, width: 250, height: 300)
        let newexpressionImage = UIImage.ResizeÜIImage(image:expressionImage, width: 250, height: 300)
        
        let newbeardImage = UIImage.ResizeÜIImage(image:beardImage, width: 250, height: 300)
        let newglassesImage = UIImage.ResizeÜIImage(image:glassesImage, width: 250, height: 300)
        let newhokuroImage = UIImage.ResizeÜIImage(image:hokuroImage, width: 250, height: 300)
        
        return [newbackImage!, newoutlineImage!, newfrontImage!, newexpressionImage!, newbeardImage!, newglassesImage!, newhokuroImage!]
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
