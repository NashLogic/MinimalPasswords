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
    }
    
    func createCAGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.gray.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
