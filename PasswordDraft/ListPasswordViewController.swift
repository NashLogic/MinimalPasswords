//
//  ListPasswordViewController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 23/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit
import SQLite
import SQLite3

class ListPasswordsViewController: UIViewController {
    
    struct passwordRows {
        var id:Int32 = 0
        var company:String = ""
        var login:String = ""
        var password:String = ""
        var directory:String = ""
        var within:String = ""
    }
    
    var globalDatabase: OpaquePointer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if globalDatabase == nil {
            print("no connection to database")
        } else {
            print("connection successful")
        }
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func retrievePasswords(queryStatementString:String, passwordRow:Array<passwordRows>) -> Array<passwordRows>{
        var queryStatement: OpaquePointer?
        var passwordRow = passwordRow
      
        if sqlite3_prepare_v2(globalDatabase, queryStatementString, -1, &queryStatement, nil) ==
          SQLITE_OK {
        
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var currentPasswordRow = passwordRows(id: 0, company: "", login: "", password: "", directory: "", within: "")

                let id = sqlite3_column_int(queryStatement, 0)
               
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
                    print("Company result is nil")
                    return passwordRow
                }
                
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    print("Login result is nil")
                    return passwordRow
                }
                
                guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                    print("Password result is nil")
                    return passwordRow
                }
                
                guard let queryResultCol4 = sqlite3_column_text(queryStatement, 4) else {
                    print("Directory result is nil")
                    return passwordRow
                }
                
                guard let queryResultCol5 = sqlite3_column_text(queryStatement, 5) else {
                    print("Within result is nil")
                    return passwordRow
                }
                
                let name = String(cString: queryResultCol1)
                let login = String(cString: queryResultCol2)
                let password = String(cString: queryResultCol3)
                let directory = String(cString: queryResultCol4)
                let within = String(cString: queryResultCol5)
            
                currentPasswordRow.id = id
                currentPasswordRow.company = name
                currentPasswordRow.login = login
                currentPasswordRow.password = password
                currentPasswordRow.directory = directory
                currentPasswordRow.within = within
                
                passwordRow.append(currentPasswordRow)
                
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(globalDatabase))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return passwordRow
    }


    
    @IBAction func listPasswords(_ sender: Any) {
        var passwordArray = Array<passwordRows>()
        passwordArray = retrievePasswords(queryStatementString: "SELECT * FROM passwordsTable", passwordRow: passwordArray)
        
        for password in passwordArray {
            print("company: \(password.company) | password: \(password.password) | dir: \(password.directory) | within: \(password.within)")
        }
        
        print("Password Array count is: \(passwordArray.count)")
        
        let newButton = CustomButton()
        view.addSubview(newButton)
        newButton.setTitle("Button", for: .normal)
        newButton.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 2 statements below are for (h x w)
//        newButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        newButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        // 2 statements below are positioning coordinates for the view
//        newButton.centerXAnchor.constraint(equalTo: listPasswords).isActive = true
//        newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        
        
        
        
        
        
        
//        do {passwordText1.text! = "id: \(passwordArray[1].id) | company: \(String(describing: passwordArray.first?.company)) | login: \(String(describing: passwordArray.first?.login)) | password: \(String(describing: passwordArray.first?.password))"
//        passwordText2.text! = "id: \(passwordArray[2].id) | company: \(passwordArray[2].company) | login: \(passwordArray[2].login) | password: \(passwordArray[2].password)"
//        passwordText3.text! = "id: \(passwordArray[3].id) | company: \(passwordArray[3].company) | login: \(passwordArray[3].login) | password: \(passwordArray[3].password)"
//        } catch {
//            print(error)
//        }
        
        

    }
    
    
    

    
}
