//
//  Person.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import RealmSwift

class Person: Object{
    
    @objc dynamic var id = 0
    
    //似顔絵パーツ
    @objc dynamic var back = ""
    @objc dynamic var outline = ""
    @objc dynamic var front = ""
    
    @objc dynamic var exprassion = ""
    
    //名前
    @objc dynamic var name = ""
    
    //メモ内容(複数)
    let contents = List<Memo>()
    
    //カテゴリ内容
    @objc dynamic var category:Category?
    
    
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
    
}


