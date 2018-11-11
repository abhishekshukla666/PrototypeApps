//
//  FloatingActionButton.swift
//  MaterialDesign
//
//  Created by Abhishek Shukla on 19/10/18.
//  Copyright © 2018 Abhishek Shukla. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {

    override func draw(_ rect: CGRect) {
//        layer.cornerRadius = frame.height / 2
        layer.backgroundColor = UIColor.red.cgColor

        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
                self.backgroundColor = #colorLiteral(red: 0.7647, green: 0.1686, blue: 0.1176, alpha: 1) /* #c32b1e */
            } else {
                self.transform = .identity
                self.backgroundColor = #colorLiteral(red: 0.9176, green: 0.2, blue: 0.1373, alpha: 1) /* #ea3323 */
            }
        })
        
        return super.beginTracking(touch, with: event)
    }
}
