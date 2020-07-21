//
//  MainMenu.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 22/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MainMenuViewController: UIViewController {
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        createCAGradientLayer()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(switchToGeneratePasswordVC))
        
    }
    
    @objc func switchToGeneratePasswordVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let GeneratePasswordViewController = storyBoard.instantiateViewController(withIdentifier: "GeneratePasswordScreen")
        self.present(GeneratePasswordViewController, animated: true, completion: nil)
    }
    
    func createCAGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.ghostWhite.cgColor, UIColor.charcoal.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
