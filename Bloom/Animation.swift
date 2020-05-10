//
//  Animation.swift
//  Bloom
//
//  Created by Jayson Tan on 5/8/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // Fade In any UIObject
    func fadeIn() {
        UIView.animate(withDuration: 2.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            // Think of .alpha as the opacity level: 1.0 = 100%
            self.alpha = 1.0
        }, completion: nil)

    }

    // Fade Out any UIObject
    func fadeOut() {

        UIView.animate(withDuration: 2.25, delay: 1.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            // Think of .alpha as the opacity level: 0.0 = 0%
            self.alpha = 0.25
        }, completion: nil)

    }
}
