//
//  FSMailService.swift
//  PhoneEmail
//
//  Created by abhishek shukla on 17/06/19.
//  Copyright © 2019 abhishek shukla. All rights reserved.
//

import Foundation
import MessageUI

struct FSEmail {
    let email: [String]
    let message: String
}

protocol FSMailServiceDelegate {
    func didFinish(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
}

class FSMailService: NSObject, MFMailComposeViewControllerDelegate {
    
    static let shared = FSMailService()
    private var delegate: FSMailServiceDelegate? = nil
    private override init() {}
    
    func sendEmail(delegate: UIViewController, emailObj: FSEmail) {
        self.delegate = delegate as? FSMailServiceDelegate
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(emailObj.email)
            mail.setMessageBody("<p>\(emailObj.message)</p>", isHTML: true)
            UIApplication.shared.keyWindow?.rootViewController?.present(mail, animated: true, completion: nil)
        } else {
            setupMail(email: emailObj.email[0])
        }
    }
    
    private func setupMail(email: String) {
        let alertController = UIAlertController (title: "Setup Mail", message: "Your mail is not setup, to set up go to settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: "mailto:\(email)") else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if (delegate != nil) {
            delegate?.didFinish(controller, didFinishWith: result, error: error)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
