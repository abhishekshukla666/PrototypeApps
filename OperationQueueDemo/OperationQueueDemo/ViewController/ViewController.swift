//
//  ViewController.swift
//  OperationQueueDemo
//
//  Created by Abhishek Shukla on 22/03/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queueManager = QueueManager.shared
        let operation = UserOperation { (result) in
            switch result {
            case .failure(let error):
                print("ERROR: \(error)")
            case .success(let apiResponse):
                for user in apiResponse.result {
                    print(user)
                }
            }
        }
        queueManager.enqueue(operation)
    }
}

