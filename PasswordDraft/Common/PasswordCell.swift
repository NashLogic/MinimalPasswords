//
//  PasswordCell.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 15/5/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {

    @IBOutlet weak var CompanyNameLabel: UILabel!
    
    @IBOutlet weak var LoginLabel: UILabel!
    
    @IBOutlet weak var PasswordLabel: UILabel!
    
    func setPassword(passwordRow: passwordRows) {
        CompanyNameLabel.text = passwordRow.company
        LoginLabel.text = passwordRow.login
        PasswordLabel.text = passwordRow.password
    }
    
}
