//
//  Extension.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/17.
//

import UIKit
import RealmSwift
import TagListView

// MARK: - UIColor

extension UIColor{
    struct MyTheme {
        static var buttonColor: UIColor {return UIColor(red: 0.29, green: 0.12, blue: 0.98, alpha: 1)}
        static var backgroundColor: UIColor {return UIColor(red: 255/255, green: 250/255, blue: 240/255, alpha: 1)}
        static var labelColor: UIColor {return UIColor(red: 245/255, green: 222/255, blue: 179/255, alpha: 1)}
        static var iconColor: UIColor {return UIColor(red: 139/255, green: 69/255, blue: 55/255, alpha: 1)}
        static var tabBarColor: UIColor {return UIColor(red: 245/255, green: 222/255, blue: 179/255, alpha: 1)}
    }
}

// MARK: - ViewController

extension ViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
    
        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}

// MARK: - TagListView

extension TagListView{
    
    //TagListViewの見た目カスタマイズ
    class func CustomTagListView(tagListView: TagListView){
        
        // タグの削除ボタンを有効に
        tagListView.enableRemoveButton = true
        
        // 今回は削除ボタン押された時の処理を行う
        
        
        // タグの見た目を設定
        tagListView.alignment = .left
        tagListView.cornerRadius = 3
        tagListView.textColor = UIColor.black
        tagListView.borderColor = UIColor.lightGray
        tagListView.borderWidth = 1
        tagListView.paddingX = 10
        tagListView.paddingY = 5
        tagListView.textFont = UIFont.systemFont(ofSize: 16)
        tagListView.tagBackgroundColor = UIColor.white
        
        // タグ削除ボタンの見た目を設定
        tagListView.removeButtonIconSize = 10
        tagListView.removeIconLineColor = UIColor.black
        
    }
    
}

// MARK: - UILabel

extension UILabel{
    
    class func CustomUILabel(label: UILabel){
        
        label.backgroundColor = UIColor.white
        label.layer.borderColor = UIColor.MyTheme.labelColor.cgColor
        //label.layer.borderWidth = 1.0
        //label.layer.masksToBounds = true
        //label.layer.cornerRadius = 10.0
    }
}

class PaddingLabel: UILabel {

    var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var contentSize = super.sizeThatFits(size)
        contentSize.width += padding.left + padding.right
        contentSize.height += padding.top + padding.bottom
        return contentSize
    }
}

// MARK: - UITextView

extension UITextView{
    
    //textViewの見た目をカスタマイズ
    class func CustomTextView(textView: UITextView){
        
        textView.layer.borderColor = UIColor.MyTheme.tabBarColor.cgColor
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.layer.masksToBounds = true
    }
    
}


// MARK: - UITextField

extension UITextField{
    
    //textFieldの見た目をカスタマイズ
    class func CustomTextField(textField: UITextField){
        
        textField.layer.borderColor = UIColor.MyTheme.tabBarColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10.0
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        
    }
}

// MARK: - UIImage

extension UIImage{
    
    //合成する画像のサイズを調整
    class func ResizeÜIImage(image : UIImage,width : CGFloat, height : CGFloat)-> UIImage!{

            // 指定された画像の大きさのコンテキストを用意.
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))

            // コンテキストに画像を描画する.
            image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

            // コンテキストからUIImageを作る.
            let newImage = UIGraphicsGetImageFromCurrentImageContext()

            // コンテキストを閉じる.
            UIGraphicsEndImageContext()

            return newImage
        }
    
    //画像を合成する
    class func ComposeUIImage(UIImageArray : [UIImage], width: CGFloat, height : CGFloat)->UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        // UIImageのある分回す.
        for image : UIImage in UIImageArray {
            
            // コンテキストに画像を描画する.
            image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    //Imageをファイルに保存
    class func ImagefileSave(person: Person, faceImage: UIImage){
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
        var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    // ドキュメントディレクトリの「パス」（String型）定義
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    let realm = try! Realm()
    
    let filename = String(person.id)
        
         // DocumentディレクトリのfileURLを取得
         if documentDirectoryFileURL != nil {
             // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = documentDirectoryFileURL.appendingPathComponent(filename)
             documentDirectoryFileURL = path
         }
        
        //pngで保存する場合
    let pngImageData = faceImage.pngData()
        
        do {
            try pngImageData!.write(to: documentDirectoryFileURL)
            }catch {
                //エラー処理
                print("エラー")
            }
        //②「Documents下のパス情報をRealmに保存する」
        try! realm.write(){
            
            person.faceImageFilepath = "\(filename)"
            realm.add(person)
        }
    }
}
