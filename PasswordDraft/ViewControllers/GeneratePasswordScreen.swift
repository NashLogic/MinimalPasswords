//
//  ViewController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 19/12/19.
//  Copyright © 2019 Nicholas Glover. All rights reserved.
//

import UIKit
import Foundation
import SQLite
import SQLite3



class ViewController: UIViewController {
    
    
    // Before anything, initiate the database of type Connection
    var globalDatabase: OpaquePointer?
    var db: OpaquePointer?
    var loweralpha:Bool = true
    var upperalpha:Bool = true
    var numbers:Bool = true
    var symbols:Bool = true

    
    // Create the first table, if it doesn't exist
    let passwordsTable = Table("passwordsTable")
    let id = Expression<Int>("id")
    let company = Expression<String>("company")
    let login = Expression<String>("login")
    let passwordForCompany = Expression<String>("passwordForCompany")
    
    
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
    
    
    func insert(insertStatementString:String) {
      var insertStatement: OpaquePointer?
      // 1
      if sqlite3_prepare_v2(globalDatabase, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
        } else {
          print("\nCould not insert row.")
        }
      } else {
        print("\nINSERT statement is not prepared.")
      }
      // 5
      sqlite3_finalize(insertStatement)
    }

    
    @IBAction func savePassword(_ sender: Any) {
        if textField.text != "" {
            let passwordToBeSaved = textField.text!
            let companyToBeSaved = companyName.text!
            let usernameToBeSaved = username.text!
            do {
                let insertStatementString = "INSERT INTO passwordsTable (id, login, company, password, directory, within) VALUES (null, '\(companyToBeSaved)',   '\(usernameToBeSaved)', '\(passwordToBeSaved)',  'rec', 'main')"
                insert(insertStatementString: insertStatementString)
                print("Successfully saved password to database")
                
                let alert = UIAlertController(title: "Password saved", message:
                    "Press enter to continue", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Enter", style: UIAlertAction.Style.default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                    
            } catch {
                print(error)
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
