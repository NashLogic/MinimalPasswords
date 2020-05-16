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
import SwiftUI


class ListPasswordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Initial database setup
    var globalDatabase: OpaquePointer?
    var passwordArray = Array<passwordRows>()
    var passwordList = Array<passwordRows>()
    var myTableView: UITableView  =   UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if globalDatabase == nil {
            print("no connection to database")
        } else {
            print("connection successful")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "passwordCell")
        
        safeArea = view.layoutMarginsGuide
        setupTableView()
        passwordList = retrievePasswords(queryStatementString: "SELECT * FROM passwordsTable", passwordRow: passwordArray)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    

    
    
    //==============================================//
    //             Presentation: UIView             //
    //==============================================//
    
    var safeArea: UILayoutGuide!
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    //==============================================//
    //                 Functionality                //
    //==============================================//
       
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func retrievePasswords(queryStatementString:String, passwordRow:Array<passwordRows>) -> Array<passwordRows>
    {
        var queryStatement: OpaquePointer?
        var passwordRow = passwordRow
      
        if sqlite3_prepare_v2(globalDatabase, queryStatementString, -1, &queryStatement, nil) ==
          SQLITE_OK {
        
            // Iterate through all the rows of the database
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
                
                let name = String(cString: queryResultCol1)
                let login = String(cString: queryResultCol2)
                let password = String(cString: queryResultCol3)
            
                currentPasswordRow.id = id
                currentPasswordRow.company = name
                currentPasswordRow.login = login
                currentPasswordRow.password = password
                
                passwordRow.append(currentPasswordRow)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(globalDatabase))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return passwordRow
    }


    
    @IBAction func listPasswords(_ sender: Any)
    {
        var passwordArray = Array<passwordRows>()
        passwordArray = retrievePasswords(queryStatementString: "SELECT * FROM passwordsTable", passwordRow: passwordArray)
        
        for password in passwordArray {
            print("company: \(password.company) | login: \(password.login) | password: \(password.password) ")
        }
        
        print("Password Array count is: \(passwordArray.count)")
        
        let newButton = CustomButton()
        view.addSubview(newButton)
        newButton.setTitle("Button", for: .normal)
    }

    
}

extension ListPasswordsViewController: UITableViewDataSource, UITableViewDelegate {
    // how many rows do we want to display?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordList.count
    }
    
    // this is each individual cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let individualCell = passwordList[indexPath.row]

        let passwordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordCell
        
        passwordCell.setPassword(passwordRow: individualCell)
        
        return passwordCell
    }
}
