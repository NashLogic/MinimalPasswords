//
//  Realm.swift
//  MinimalPasswords
//
//  Created by Nicholas Glover on 12/7/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import RealmSwift

class Password : Object {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var company = ""
    @objc dynamic var login = ""
    @objc dynamic var password = ""
}

extension Realm {
    
}
