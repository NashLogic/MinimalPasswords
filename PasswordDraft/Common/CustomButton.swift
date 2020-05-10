//
//  CustomButton.swift
//  PasswordDraft
//
//  Created by Nicholas Glover on 9/2/20.
//  Copyright © 2020 Nicholas Glover. All rights reserved.
//

import UIKit

class CustomButton : UIButton {
    
    // when initialised programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    // when initialised via the storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor      = UIColor.blue
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius   = 25
        layer.borderWidth    = 3.0
        layer.borderColor    = UIColor.darkGray.cgColor
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    func setPosition() {
        
    }
    
    
}
