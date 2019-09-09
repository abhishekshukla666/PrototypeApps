//
//  FSCallable.swift
//  PhoneEmail
//
//  Created by abhishek shukla on 17/06/19.
//  Copyright © 2019 abhishek shukla. All rights reserved.
//

import UIKit

protocol Callable {
    func callNumber(_ number: String)
}

extension Callable {
    
    func callNumber(_ phoneNumber: String) {
        
        if let phoneCallURL = URL(string: "telprompt://\("+"+phoneNumber)") {
            
            let application: UIApplication = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
