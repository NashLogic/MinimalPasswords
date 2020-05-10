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
import SwiftUI

class MainMenuViewController: UIViewController {
    
    var globalDatabase:OpaquePointer?
    let databaseName = "passwordsTable"
    let passwordsTable = Table("passwordsTable")
    let id = Expression<Int>("id")
    let company = Expression<String>("company")
    let login = Expression<String>("login")
    let passwordForCompany = Expression<String>("passwordForCompany")
    
    
    func dropTable() {
        var dropTableStatement: OpaquePointer?
        let dropTableString = "DROP TABLE passwordsTable"
        
        if sqlite3_prepare_v2(globalDatabase, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("passwordsTable was dropped")
            } else {
                print("passwordsTable did not drop")
            }
        } else {
            print("Drop table statement was not prepared")
        }
        
        sqlite3_finalize(dropTableStatement)
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
    
    
    let createTableString = "CREATE TABLE passwordsTable(id INTEGER PRIMARY KEY, login VARCHAR(255), company VARCHAR(255), password VARCHAR(255), directory CHAR(3), within VARCHAR(255))"
    
    
    func createTable() {
        var createTableStatement: OpaquePointer?
      
        if sqlite3_prepare_v2(globalDatabase, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("\nContact table created.")
            } else {
                print("\nContact table is not created.")
            }
        } else {
            print("\nCREATE TABLE statement is not prepared.")
        }
      
        sqlite3_finalize(createTableStatement)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = openDatabase()
        globalDatabase = database
//        dropTable()
        createTable()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ListPasswordsViewController {
            destinationVC.globalDatabase = globalDatabase
        } else if let destination2VC = segue.destination as? ViewController {
            destination2VC.globalDatabase = globalDatabase
        }
    }
    
    
    
    @IBSegueAction func showSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: ""))
    }
    
}
