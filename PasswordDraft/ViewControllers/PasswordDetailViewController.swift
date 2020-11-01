//
//  PasswordDetailViewController.swift
//  MinimalPasswords
//
//  Created by Nicholas Glover on 13/8/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PasswordDetailsViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameDisplay: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordDisplay: UILabel!
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        usernameDisplay.text = username
        passwordDisplay.text = password
    }
}

