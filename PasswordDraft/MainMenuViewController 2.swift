//
//  MainMenu.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 22/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit
import SQLite
import SQLite3

class MainMenuViewController: UIViewController {
    
    var globalDatabase:OpaquePointer!
    let databaseName = "passwordsTable"
    let passwordsTable = Table("passwordsTable")
    let id = Expression<Int>("id")
    let company = Expression<String>("company")
    let login = Expression<String>("login")
    let passwordForCompany = Expression<String>("passwordForCompany")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = openDatabase()
        globalDatabase = database
         
    }
    
   
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        let fileURL = try! FileManager.default
        .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("login.").appendingPathExtension("sqlite3")
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
          print("Successfully opened connection to database at \(databaseName)")
          return db
        } else {
          print("Unable to open database.")
        }
        return db
    }
    
    let createTableString = "CREATE TABLE passwordsTable(id INT PRIMARY KEY NOT NULL AUTO-INCREMENT, login VARCHAR(255), company VARCHAR(255), password VARCHAR(255);"
    
   func createTable() {
     // 1
     var createTableStatement: OpaquePointer?
     // 2
     if sqlite3_prepare_v2(globalDatabase, createTableString, -1, &createTableStatement, nil) ==
         SQLITE_OK {
       // 3
       if sqlite3_step(createTableStatement) == SQLITE_DONE {
         print("\nContact table created.")
       } else {
         print("\nContact table is not created.")
       }
     } else {
       print("\nCREATE TABLE statement is not prepared.")
     }
     // 4
     sqlite3_finalize(createTableStatement)
   }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let firstDestinationVC = segue.destination as? ListPasswordsViewController
        firstDestinationVC!.globalDatabase = globalDatabase
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondDestinationVC = segue.destination as? ViewController
        secondDestinationVC!.globalDatabase = globalDatabase
    }
    
    


    
    @IBAction func ListTapped(_ sender: Any) {
        do {
            
            print("List tapped")
            let createTableString = "CREATE TABLE passwordsTable(id INT PRIMARY KEY NOT NULL, login VARCHAR(255), company VARCHAR(255), password VARCHAR(255));"
             
            func createTable() {
              // 1
              var createTableStatement: OpaquePointer?
              // 2
              if sqlite3_prepare_v2(globalDatabase, createTableString, -1, &createTableStatement, nil) ==
                  SQLITE_OK {
                // 3
                if sqlite3_step(createTableStatement) == SQLITE_DONE {
                  print("passwordsTable table created.")
                } else {
                  print("passwordsTable table is not created.")
                }
              } else {
                print("\nCREATE TABLE statement is not prepared.")
              }
              // 4
              sqlite3_finalize(createTableStatement)
            }
            
            createTable()
            
            
//            print("In the do-loop")
//            let savePasswordQuery = self.passwordsTable.insert(self.company <- "Kmart", self.login <- "nickjesus3", self.passwordForCompany <- "passwordToBeSaved")
//            try self.database.run(savePasswordQuery)
//            print("Successfully saved password to database")
//
//
//            // grab the sequence from the table and put it into a variable
//            let passwords = try database.prepare(passwordsTable)
//
//            // list the variable with a for-each loop (because it is a sequence structure)
//            for password in passwords {
//                print("id: \(password[self.id]), company: \(password[self.company]), login: \(password[self.login]), password: \(password[self.passwordForCompany])")
//            }
//        } catch {
//            print(error)
//        }
        }
    }
    
    
    
    
}
