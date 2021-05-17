//
//  Memo.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import RealmSwift

class Memo: Object{
    //管理用ID。プライマリーキー
    @objc dynamic var id = 0
    
    //メモの中身
    @objc dynamic var memo: String = ""

    
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
}

