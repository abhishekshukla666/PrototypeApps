//
//  UserMOD.swift
//  OperationQueueDemo
//
//  Created by Abhishek Shukla on 23/03/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import Foundation

struct ApiResponse {
    let result: [User]
}

extension ApiResponse: Decodable {
    
    private enum ApiResponseCodingKeys: String, CodingKey {
        case result = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        result = try container.decode([User].self, forKey: .result)
    }
}

struct User {
    let age: Int
    let name: String
    let emailId: String
}

extension User: Decodable {
    
    private enum UserKeys: String, CodingKey {
        case age
        case name
        case emailId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        age = try container.decode(Int.self, forKey: .age)
        name = try container.decode(String.self, forKey: .name)
        emailId = try container.decode(String.self, forKey: .emailId)
    }
}
