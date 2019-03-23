//
//  QueueManager.swift
//  OperationQueueDemo
//
//  Created by Abhishek Shukla on 22/03/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation

class QueueManager {
    
    lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        
        return queue;
    }()
    
    // MARK: - Singleton
    
    static let shared = QueueManager()
    private init() {}
    
    // MARK: - Addition
    
    func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }
}
