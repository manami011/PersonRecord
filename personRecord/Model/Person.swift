//
//  Person.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import RealmSwift

class Person: Object{
    
    @objc dynamic var id = 0
    
    //faceImageのパス
    @objc dynamic var faceImageFilepath = ""
    
    
    //似顔絵パーツ番号--------------
    //前髪、後ろ髪、輪郭
    @objc dynamic var frontNumber = 0
    @objc dynamic var backNumber = 0
    @objc dynamic var outlineNumber = 0
    
    @objc dynamic var exprassionNumber = 0
    
    //眉毛,口
    @objc dynamic    var eyebrowsNumber = 0
    @objc dynamic    var mouthNumber = 0
    
    //ひげ,メガネ,ほくろ
    @objc dynamic    var beardNumber = 0
    @objc dynamic    var glassesNumber = 0
    @objc dynamic    var hokuroNumber = 0
    
    
    
    //カラー番号-------------------
    
    //髪の毛、肌
    @objc dynamic var haircolorNumber = 0
    @objc dynamic var outlinecolorNumber = 0
    
    
    //眉毛
    @objc dynamic    var eyebrowscolorNumber = 0
    
    //ひげ、メガネ
    @objc dynamic    var beardcolorNumber = 0
    @objc dynamic    var glassescolorNumber = 0
    
    //------------------------------------
    
    //名前
    @objc dynamic var name = ""
    @objc dynamic var furigana = ""
    
    //メモ内容(複数)
    @objc dynamic var memo1 = ""
    @objc dynamic var memo2 = ""
    @objc dynamic var memo3 = ""
    
    //TODO:カテゴリーを持たせる
    var personCategory = List<PersonCategory>()
    
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
    
}


