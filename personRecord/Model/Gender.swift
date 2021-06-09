//
//  Gender.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/07.
//

import RealmSwift

class Gender: Object{
 
    @objc dynamic var gender = ""
    
    //idをプライマリーキーとして設定
    override static func primaryKey() -> String?{
        return "id"
    }
    
    var personGender = List<PersonGender>()
    
}
