//
//  Memo.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/13.
//

import RealmSwift

class PersonCategory: Object{
    
    @objc dynamic var person: Person?
    @objc dynamic var category: Category?
    let ownerPerson = LinkingObjects(fromType: Category.self, property: "personCategory")
    let ownerCategory = LinkingObjects(fromType: Person.self, property: "personCategory")
    
}

