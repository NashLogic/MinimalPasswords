//
//  Password.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 11/5/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation

class passwordRows {
    var id:Int32 = 0
    var company:String = ""
    var login:String = ""
    var password:String = ""
    var directory:String = ""
    var within:String = ""
    
    init(id: Int32, company: String, login: String, password: String, directory: String, within: String) {
        self.id = id
        self.company = company
        self.login = login
        self.password = password
        self.directory = directory
        self.within = within
    }
}
