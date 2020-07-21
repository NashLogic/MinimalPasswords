//
//  MainNavigationController.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 19/1/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationItem.title = "Minimal"
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.blueSapphire,
         NSAttributedString.Key.font: UIFont(name: "Serif", size: 21)!]
    }
}
