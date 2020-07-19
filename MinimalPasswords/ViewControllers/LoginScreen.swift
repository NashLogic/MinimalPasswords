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
    var gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        createCAGradientLayer()
     
        LoginText.layer.borderWidth = 1
        LoginText.layer.borderColor = UIColor.davysGray.cgColor
        LoginText.attributedPlaceholder = NSAttributedString(string: "Enter login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        LoginText.layer.cornerRadius = 10
        LoginText.addConstraint(LoginText.heightAnchor.constraint(equalToConstant: 35))
        
        PasswordText.layer.borderWidth = 1
        PasswordText.layer.borderColor = UIColor.davysGray.cgColor
        PasswordText.layer.cornerRadius = 10
        PasswordText.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        PasswordText.addConstraint(PasswordText.heightAnchor.constraint(equalToConstant: 35))

    }
    
    func createCAGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.ghostWhite.cgColor, UIColor.blueSapphire.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        
        present (mainNavigationVC, animated: true, completion: nil)
    }
}
