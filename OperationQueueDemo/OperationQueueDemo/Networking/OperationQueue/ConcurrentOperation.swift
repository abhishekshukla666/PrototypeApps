//
//  ConcurrentOperation.swift
//  OperationQueueDemo
//
//  Created by Abhishek Shukla on 22/03/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(String)
}

class ConcurrentOperation<T>: Operation {
    
    typealias OperationCompletionHandler = (_ result: Result<T>) -> Void
    
    var completionHandler: (OperationCompletionHandler)?
    
    // MARK: - State
    
    private enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    // MARK: - Start
    
    override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        if !isExecuting {
            state = .executing
        }
        
        main()
    }
    
    // MARK: - Finish
    
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
    func complete(result: Result<T>) {
        finish()
        
        if !isCancelled {
            completionHandler?(result)
        }
    }
    
    // MARK: - Cancel
    
    override func cancel() {
        super.cancel()
        
        finish()
    }
}
