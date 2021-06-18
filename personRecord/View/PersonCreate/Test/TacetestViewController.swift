//
//  TacetestViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/11.
//

import UIKit
import RealmSwift


class TacetestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    
    
    var faceData: FaceData?
    let realm = try! Realm()
    var person: Person?
    var personCategory: PersonCategory?
    
    
    @IBOutlet weak var collectionFaceCreateView: CollectionFaceCreateView!
    
    
    weak var delegate: Slider?
    
    
    @IBOutlet weak var faceCreateView: FaceCreateView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CollectionFaceCreateView", bundle: nil)
        collectionFaceCreateView = nib.instantiate(withOwner: self, options: nil).first as? CollectionFaceCreateView
        
        // カスタムセルを登録する
        let cnib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionFaceCreateView.collectionView1.register(cnib, forCellWithReuseIdentifier: "Cell")
        collectionFaceCreateView.collectionView1.collectionViewLayout = collectionViewLayout()
        
        self.view.addSubview(collectionFaceCreateView)
        
        
        let fv = collectionFaceCreateView.faceView
        faceData?.faceImageArray = [fv!.back, fv!.outline, fv!.front, fv!.eye, fv!.eyebrows, fv!.mouth, fv!.glasses, fv!.hokuro, fv!.beard]
        
        
        faceData = FaceData()
        faceData?.setNumArray()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    //コレクションビューのレイアウト
    func collectionViewLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        
        return layout
    }
    
    
    func changeImage(_ slider: UISlider) {
        
        let num = Int(slider.value)
        var setName = ""
        
        if slider == faceCreateView.slider1{
            
            setName = "back"
            faceCreateView.back.image = faceData?.getImageSouce(name: "back", num1: num, num2: faceData!.haircolorNumber)
            
        }else if slider == faceCreateView.slider2{
            
            setName = "front"
            faceCreateView.front.image = faceData?.getImageSouce(name: "front", num1: num, num2: faceData!.haircolorNumber)
            
        }else if slider == faceCreateView.slider3{
            
            setName = "outline"
            faceCreateView.front.image = faceData?.getImageSouce(name: "outline", num1: num, num2: faceData!.outlinecolorNumber)
            
        }else if slider == faceCreateView.slider4{
            
            setName = "haircolor"
            
            faceCreateView.back.image = faceData?.getImageSouce(name: "back", num1: faceData!.backNumber, num2: num)
            faceCreateView.front.image = faceData?.getImageSouce(name: "front", num1: faceData!.frontNumber, num2: num)
        }
        faceData?.setNumber(name: setName, num: num)
    }
    
    func sliderMove(){
        
        return self.delegate!.sliderMove(numArray: faceData!.numArray)
       }
    
    
    //全体を保存
    @objc func SaveFace(_ sender: Any) {
       
        try! realm.write{
            //パーツ番号
            self.person!.backNumber = faceData!.backNumber
            self.person!.outlineNumber = faceData!.outlineNumber
            self.person!.frontNumber = faceData!.frontNumber
            
            self.person!.eyeNumber = faceData!.eyeNumber
            self.person!.eyebrowsNumber = faceData!.eyebrowsNumber
            self.person!.mouthNumber = faceData!.mouthNumber
            
            self.person!.beardNumber = faceData!.beardNumber
            self.person!.glassesNumber = faceData!.glassesNumber
            self.person!.hokuroNumber = faceData!.hokuroNumber
            
            //カラー番号
            self.person!.haircolorNumber = faceData!.haircolorNumber
            self.person!.beardcolorNumber = faceData!.beardcolorNumber
            self.person!.glassescolorNumber = faceData!.glassesNumber
            
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
    
    
    func imageSet(){
        
        let imageArray = faceData?.ImageArray()
        
        for i in 0...imageArray!.count-1{
            
            faceCreateView.FaceImageArray![i].image = imageArray![i]
        }
    }
    
    //画像を合成する
    func CompositeIgame() -> UIImage {
      
        let composedImage = UIImage.ComposeUIImage(UIImageArray: ResizeÜIImage(), width: 215, height: 247)
        return composedImage!
    }
    
    
    //合成画像生成
    func ResizeÜIImage() -> [UIImage]{
        
        let imageArray = faceData?.ImageArray()
        var newImageArray: [UIImage]?
        
        let width = 215
        let height = 247
        
        
        for i in 0...imageArray!.count-1{
            
            let img = UIImage.ResizeÜIImage(image:imageArray![i], width: CGFloat(width), height: CGFloat(height))
            newImageArray?.append(img!)
        }
        
        return newImageArray!
    }
    
}
