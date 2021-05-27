//
//  Category.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import RealmSwift

class Category: Object{
    //管理用ID。プライマリーキー
    @objc dynamic var id = 0
    
    //カテゴリ名
    @objc dynamic var categoryName:String = ""

    var personCategory = List<PersonCategory>()
    
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
}
