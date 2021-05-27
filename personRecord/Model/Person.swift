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
    
    
    //似顔絵パーツ番号
    @objc dynamic var backNumber = 0
    @objc dynamic var outlineNumber = 0
    @objc dynamic var frontNumber = 0
    
    @objc dynamic var exprassionNumber = 0
    
    //カラー番号
    @objc dynamic var backcolorNumber = 0
    @objc dynamic var outlinecolorNumber = 0
    @objc dynamic var frontcolorNumber = 0
    
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


