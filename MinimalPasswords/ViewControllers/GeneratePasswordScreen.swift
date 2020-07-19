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
    var gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        companyName.layer.borderWidth = 1
        companyName.layer.borderColor = UIColor.black.cgColor
        companyName.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        companyName.layer.cornerRadius = 10
        companyName.addConstraint(companyName.heightAnchor.constraint(equalToConstant: 35))
        
        username.layer.borderWidth = 1
        username.layer.borderColor = UIColor.black.cgColor
        username.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        username.layer.cornerRadius = 10
        username.addConstraint(username.heightAnchor.constraint(equalToConstant: 35))
        
        passwordLength.layer.borderWidth = 1
        passwordLength.layer.borderColor = UIColor.black.cgColor
        passwordLength.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        passwordLength.layer.cornerRadius = 10
        passwordLength.addConstraint(passwordLength.heightAnchor.constraint(equalToConstant: 35))
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.layer.cornerRadius = 10
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 35))
        
        createCAGradientLayer()
    }

    func createCAGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkCloudBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
