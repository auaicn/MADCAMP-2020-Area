//
//  AppDesignComponent.swift
//  Area
//
//  Created by Wooseong Kim on 2020/08/04.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import Foundation
import UIKit

class UIRoundPrimaryButton: UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)!
        self.layer.cornerRadius=30.0
        self.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha:1)
        self.tintColor = .white
    }
}

class interestButton: UIButton {
    
    var isOn = false
    
    required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)!
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        addTarget(self, action:#selector(interestButton.buttonPressed),for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        isOn = bool
        
        let color = bool ? UIColor.black : .clear
        let titleColor = bool ? .white : UIColor.black
        
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }
}
