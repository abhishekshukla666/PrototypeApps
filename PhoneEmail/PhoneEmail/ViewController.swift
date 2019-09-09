//
//  ViewController.swift
//  PhoneEmail
//
//  Created by abhishek shukla on 14/06/19.
//  Copyright © 2019 abhishek shukla. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, FSMailServiceDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func emailClicked(_ sender: UIButton) {
        let emailObj = FSEmail(email: ["abhishek.shukla@nagarro.com", "abc@gmail.com"], message: "Testing the mail service")
        FSMailService.shared.sendEmail(delegate: self, emailObj: emailObj)
    }
    
    
    func didFinish(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
    }
}

extension ViewController: Callable {
    @IBAction func phoneNumberClicked(_ sender: UIButton) {
        callNumber("+919818695807")
    }
}

