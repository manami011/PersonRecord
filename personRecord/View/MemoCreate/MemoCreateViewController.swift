//
//  MemoCreateViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift
import TagListView

class MemoCreateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    let MARGIN: CGFloat = 10
    var isObserving = false //キーボード入力時のTextView浮き上がり処理
    
    var image: UIImage!
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    //Filters
    @IBOutlet weak var filterStackView: UIStackView!
   @IBOutlet weak var filterView: FilterView!
    var maleButton: UIButton!
    var femaleButton: UIButton!
    var noGenderButton: UIButton!
    var longButton: UIButton!
    var middleButton: UIButton!
    var shortButton: UIButton!
    var glassesButton: UIButton!
    var hokuroButton: UIButton!
    var beardButton: UIButton!
    
    var btnArray: [UIButton] = []
    
    @IBOutlet weak var memo2TextViewHeight: NSLayoutConstraint!
    
    
    var person: Person?
    var category: Category?
    var personCategory: PersonCategory?
    let realm = try! Realm()
    
    var categorySearchResult : Results<Category>?
    
    var alertTextField: UITextField?
    
    var isSelected: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        setUpfaceCreateView()
        
        //TextViewカスタマイズ
        UITextView.CustomTextView(textView: memoTextView)
        
        categorySearchResult = realm.objects(Category.self)
        setTextField()
        
        memoTextView.delegate = self
        CreateToolBar()
        
        let nib = UINib(nibName: "FilterView", bundle: nil)
        filterView = nib.instantiate(withOwner: self, options: nil).first as? FilterView
        
        filterStackView.addSubview(filterView)
        
        maleButton = filterView.maleButton
        femaleButton = filterView.femaleButton
        noGenderButton = filterView.noGenderButton
        longButton = filterView.longButton
        middleButton = filterView.middleButon
        shortButton = filterView.shortButton
        glassesButton = filterView.glassesButton
        hokuroButton = filterView.hokuroButton
        beardButton = filterView.beardButton
      
        
        btnArray = [maleButton, femaleButton, noGenderButton, longButton, middleButton, shortButton, glassesButton, hokuroButton, beardButton]
        
        for btn in btnArray{
            
            btn.addTarget(self, action: #selector(self.tagChange(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    //ツールバー生成
    func CreateToolBar(){
        // ツールバー生成 サイズはsizeToFitメソッドで自動で調整される。
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //サイズの自動調整。敢えて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さない。
        toolBar.sizeToFit()
        
        // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // Doneボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        
        // BarButtonItemの配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        memoTextView.inputAccessoryView = toolBar
    }
    
    //Doneボタン押下時の処理
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    //TextView以外にタッチした時にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Viewの表示時にキーボード表示・非表示を監視するObserverを登録する
        super.viewWillAppear(animated)
        if(!isObserving) {
            let notification = NotificationCenter.default
            notification.addObserver(self, selector:#selector(keyboardWillShow)
                                     , name: UIResponder.keyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector:#selector(keyboardWillHide)
                                     , name: UIResponder.keyboardWillHideNotification, object: nil)
            isObserving = true
        }
        
        FaceImageLoad()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // Viewの表示時にキーボード表示・非表示時を監視していたObserverを解放する
        super.viewWillDisappear(animated)
        if(isObserving) {
            let notification = NotificationCenter.default
            notification.removeObserver(self)
            notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            notification.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            isObserving = false
        }
    }
    
    //キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight = 80.0  // 入力フィールドの最大サイズ
        if(memoTextView.frame.size.height.native < maxHeight) {
            let size:CGSize = memoTextView.sizeThatFits(memoTextView.frame.size)
            memo2TextViewHeight.constant = size.height
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification?) {
        // キーボード表示時の動作をここに記述する
        let rect = ((notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey])! as! NSValue).cgRectValue
        let duration:TimeInterval = (notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey])! as! Double
        UIView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -rect.size.height)
            self.view.transform = transform
        },completion:nil)
    }
    @objc func keyboardWillHide(notification: NSNotification?) {
        // キーボード消滅時の動作をここに記述する
        let duration = ((notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey])! as! Double)
        UIView.animate(withDuration: duration, animations:{
            self.view.transform = .identity
        },
        completion:nil)
    }
    
    /*
     // MARK: -Face
     */
    
    func FaceImageLoad(){
        //PersonImageのパス読み込み
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        //URL型にキャスト
        let fileURL = URL(string: documentPath + "/" + person!.faceImageFilepath)
        
        if let filePath = fileURL?.path{
            
            //パス型に変換
            personImage.image = UIImage(contentsOfFile: filePath)
            
            print("DEBUG_PRINT:filePath:\(String(describing: filePath))")
        }
        
    }
    
    //DetailVCから遷移してきた時用に値をセットする
    func setTextField(){
        
        if self.person!.memo != ""{
            memoTextView.text = self.person!.memo
        }
    }
    
    
    //faceCreateViewの準備
    func setUpfaceCreateView(){
        
        let state = UIControl.State.normal
        nameButton.setTitle(person!.name, for: state)
        personImage.image = image
        
        saveButton.addTarget(self, action: #selector(saveMemo), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func saveMemo() {
        
        let genderArray = [maleButton, femaleButton, noGenderButton]
        
        let heightArray = [longButton, middleButton, shortButton]
        
        try! realm.write{
            
            person!.memo = memoTextView.text!
            
            personCategory?.person = self.person
            self.realm.add(self.person!, update: .modified)
            
            for btn in genderArray{
                if btn?.tag == 1{
                    person!.gender = (btn?.currentTitle)!
                }
            }
            for btn in heightArray{
                if btn?.tag == 1{
                    person!.height = (btn?.currentTitle)!
                }
            }
            
            if glassesButton.tag == 1{
                person!.glasses = true
            }
            if hokuroButton.tag == 1{
                person!.hokuro = true
            }
            if beardButton.tag == 1{
                person!.beard = true
            }
            
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    let state = UIControl.State.normal
    let OfffilterImage = UIImage(named: "filter1")
    let OnfilterImage = UIImage(named: "filter2")
    
    //TagImages & tag change when btn cricked
    @objc func tagChange(sender: UIButton!){
        
        let genderArray = [maleButton, femaleButton, noGenderButton]
        let heightArray = [longButton, middleButton, shortButton]
        //let otherArray = [glassesButton, hokuroButton, beardButton]
        
        if sender.currentTitle == "男性" || sender.currentTitle == "女性" || sender.currentTitle == "どちらでもない"{
            
            //reset btn tag
            for btn in genderArray{
                btn?.tag = 0
                btn?.setBackgroundImage(OfffilterImage, for: state)
            }
            sender.tag = 1
            sender.setBackgroundImage(OnfilterImage, for: state)
        }
      
        if sender.currentTitle == "高い" || sender.currentTitle == "普通" || sender.currentTitle == "低い"{
            
            //reset btn tag
            for btn in heightArray{
                btn?.tag = 0
                btn?.setBackgroundImage(OfffilterImage, for: state)
            }
            sender.tag = 1
            sender.setBackgroundImage(OnfilterImage, for: state)
        }
      
        if sender.currentTitle == "メガネ" || sender.currentTitle == "ほくろ" || sender.currentTitle == "ひげ"{
            
            //選択中→選択解除
            if sender.currentBackgroundImage == OnfilterImage{
                sender.tag = 0
                sender.setBackgroundImage(OfffilterImage, for: state)
            }else{
                sender.tag = 1
                sender.setBackgroundImage(OnfilterImage, for: state)
            }
        }
    }
    
    
}
