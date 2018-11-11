//
//  ViewController.swift
//  MaterialDesign
//
//  Created by Abhishek Shukla on 19/10/18.
//  Copyright © 2018 Abhishek Shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var floatingView: UIViewX!
    fileprivate func hideFloatingView() {
        floatingView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pencilButton.transform = CGAffineTransform(translationX: 0, y: 15)
        chatButton.transform = CGAffineTransform(translationX: 12, y: 12)
        clockButton.transform = CGAffineTransform(translationX: 15, y: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideFloatingView()
    }

    @IBAction func floatingActionButtonClicked(_ sender: FloatingActionButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.floatingView.transform == .identity {
                self.hideFloatingView()
            } else {
                
                self.floatingView.transform = .identity
            }
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.floatingView.transform == .identity {
                self.pencilButton.transform = .identity
                self.chatButton.transform = .identity
                self.clockButton.transform = .identity
            }
        })
    }
    
}

