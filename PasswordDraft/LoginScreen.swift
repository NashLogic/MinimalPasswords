//
//  LoginViewController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 19/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var LoginText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBAction func LoginTapped(_ sender: Any) {
        if LoginText.text == "" && PasswordText.text == "" {
            navigateToMainInterface()
        } else {
            let alert = UIAlertController(title: "Login credentials invalid", message:
                "Press enter to continue", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Enter", style: UIAlertAction.Style.default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    
    
    private func navigateToMainInterface() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC =  mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        
        present (mainNavigationVC, animated: true, completion: nil)
        
        
    }
}
