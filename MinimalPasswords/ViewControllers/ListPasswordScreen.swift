//
//  ListPasswordViewController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 23/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class ListPasswordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
            
    // Initial database setup
    var myTableView: UITableView  = UITableView()
    let realm = try! Realm()
    var passwordList:Array<Password> = []
    var safeArea: UILayoutGuide!
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        createCAGradientLayer()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "passwordCell")
        
        safeArea = view.layoutMarginsGuide

        passwordList = Array(realm.objects(Password.self))

        setupTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(switchToGeneratePasswordVC))
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordList = Array(realm.objects(Password.self))
        tableView.reloadData()
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    @objc func switchToGeneratePasswordVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let GeneratePasswordViewController = storyBoard.instantiateViewController(withIdentifier: "GeneratePasswordScreen")
        self.navigationController?.pushViewController(GeneratePasswordViewController, animated: true)
    }
    
    func createCAGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkCloudBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @IBAction func listPasswords(_ sender: Any)
    {
        for password in passwordList {
            print("company: \(password.company) | login: \(password.login) | password: \(password.password) ")
        }
                
        let newButton = CustomButton()
        view.addSubview(newButton)
        newButton.setTitle("Button", for: .normal)
    }
}

extension ListPasswordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let individualCell = passwordList[indexPath.row]

        let passwordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordCell
        passwordCell.backgroundColor = UIColor.ghostWhite
        
        passwordCell.setPasswordRealm(passwordRow: individualCell)
        
        return passwordCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let realm = try! Realm()
        
        if editingStyle == .delete {
            let recordToDelete = passwordList[indexPath.row]
            try! realm.write {
                realm.delete(recordToDelete)
            }
            passwordList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! PasswordDetailsViewController
        
        secondViewController.username = passwordList[tableView.indexPathForSelectedRow!.row].login
        secondViewController.password = passwordList[tableView.indexPathForSelectedRow!.row].password
    }

}
    

