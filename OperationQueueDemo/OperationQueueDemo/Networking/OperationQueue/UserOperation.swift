//
//  UserOperation.swift
//  OperationQueueDemo
//
//  Created by Abhishek Shukla on 23/03/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation

class UserOperation: ConcurrentOperation<ApiResponse> {
    
    init(completionHandler: @escaping (_ result: Result<ApiResponse>) -> Void) {
        super.init()
        self.completionHandler = completionHandler
    }
    
    override func main() {
        let nm = NetworkManager()
        nm.getUsers { (apiResponse, error) in
            
            guard let apiResponse = apiResponse else {
                self.complete(result: .failure(error!))
                return
            }
            self.complete(result: .success(apiResponse))
        }
    }
}


