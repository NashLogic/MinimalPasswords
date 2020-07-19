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

    @IBOutlet weak var ViewForUnderline: UIView!
    @IBOutlet weak var LoginText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewForUnderline = UIView(frame: CGRect(x: 70, y: 300, width: 280, height: 300))
        
        viewForUnderline.layer.borderWidth = 1
        viewForUnderline.layer.borderColor = UIColor.black.cgColor
        viewForUnderline.layer.cornerRadius = 20
//        view.addSubview(viewForUnderline)
        
        LoginText.layer.borderWidth = 1
        LoginText.layer.borderColor = UIColor.black.cgColor
        LoginText.attributedPlaceholder = NSAttributedString(string: "Enter login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        PasswordText.layer.borderWidth = 1
        PasswordText.layer.borderColor = UIColor.black.cgColor
        PasswordText.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
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
