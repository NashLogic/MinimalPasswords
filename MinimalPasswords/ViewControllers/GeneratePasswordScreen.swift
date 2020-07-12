//
//  ViewController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 19/12/19.
//  Copyright © 2019 Nicholas Glover. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ViewController: UIViewController {

    // Settings for password creation
    var loweralpha:Bool = true
    var upperalpha:Bool = true
    var numbers:Bool = true
    var symbols:Bool = true
    
    // Define all connections
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwordLength: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchatozOutlet: UISwitch!
    @IBOutlet weak var switchAtoZOutlet: UISwitch!
    @IBOutlet weak var switch0to9Outlet: UISwitch!
    @IBOutlet weak var switchSymbolsOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func savePassword(_ sender: Any) {
        if textField.text != "" {
            let passwordToBeSaved = textField.text!
            let companyToBeSaved = companyName.text!
            let usernameToBeSaved = username.text!
            
            let realm = try! Realm()
            
            let newPasswordToSave = Password()
            newPasswordToSave.company = companyToBeSaved
            newPasswordToSave.login = usernameToBeSaved
            newPasswordToSave.password = passwordToBeSaved
            
            try! realm.write {
                realm.add(newPasswordToSave)
                
                let alert = UIAlertController(title: "Password saved", message: "Press enter to continue", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Enter", style: UIAlertAction.Style.default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        } else {
            print("Cannot save as there is no password")
        }
    }
    
    @IBAction func switchatoz(_ sender: Any) {
        if switchatozOutlet.isOn {
            loweralpha = true
        } else {
            loweralpha = false
        }
    }
    
    @IBAction func switchAtoZ(_ sender: Any) {
        if switchAtoZOutlet.isOn {
            upperalpha = true
        } else {
            upperalpha = false
        }
    }

    @IBAction func switch0to9(_ sender: Any) {
        if switch0to9Outlet.isOn {
            numbers = true
        } else {
            numbers = false
        }
    }
    
    @IBAction func switchSymbolsOutlet(_ sender: Any) {
        if switchSymbolsOutlet.isOn {
                symbols = true
            } else {
                symbols = false
            }
    }
    
    @IBAction func generateButton(_ sender: Any) {
        
        textField.text = ""
        
        func randomString(_ length: Int) -> String
        {
            var letters:String = ""
            if loweralpha == true {
                letters += "abcdefghijklmnopqrstuvwxyz"
            } else {
                letters = letters.replacingOccurrences(of: "abcdefghijklmnopqrstuvwxyz", with: "")
            }
            
            if upperalpha == true {
                letters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            } else {
                letters = letters.replacingOccurrences(of: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", with: "")
            }
            
            if numbers == true {
                letters += "0123456789"
            } else {
                letters = letters.replacingOccurrences(of: "0123456789", with: "")
            }
            
            if symbols == true {
                letters += "!@#$%^&*/"
            } else {
                letters = letters.replacingOccurrences(of: "!@#$%^&*/", with: "")
            }
            
        return String((0..<length).map{ _ in letters.randomElement()! })
        }
    
        let passwordLengthInt: Int?  = Int(passwordLength.text!)
        
        if passwordLengthInt != nil {
            let randomlyGeneratedPassword = randomString(passwordLengthInt!)
            textField.text = randomlyGeneratedPassword
        }
        
        view.endEditing(true)
    }
    
    @IBAction func clearButton(_ sender: Any) {
        textField.text = ""
        let alert = UIAlertController(title: "Text Field cleared", message:
            "Press enter to continue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Enter", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
