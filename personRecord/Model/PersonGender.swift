//
//  PersonGender.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/06/07.
//

import RealmSwift

class PersonGender: Object{
 
    @objc dynamic var gender: Gender?
    @objc dynamic var person: Person?
    
    let ownerPerson = LinkingObjects(fromType: Person.self, property: "personGender")
    let ownerGender = LinkingObjects(fromType: Gender.self, property: "personGender")
}
