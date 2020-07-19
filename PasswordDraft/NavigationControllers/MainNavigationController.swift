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

        navigationBar.barTintColor = UIColor.blueSapphire
        
//        let gradient = CAGradientLayer()
//        var bounds = navigationBar.bounds
//        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
//        gradient.frame = bounds
//        gradient.colors = [UIColor.gray.cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.0, 1.0]
//
//        if let image = getImageFrom(gradientLayer: gradient) {
//            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
//        }
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
