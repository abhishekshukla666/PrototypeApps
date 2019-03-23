//
//  PlacesEndPoint.swift
//  PlacesNearby
//
//  Created by Abhishek Shukla on 21/04/18.
//  Copyright © 2018 Abhishek Shukla. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum UserApi {
    case users
}

extension UserApi: EndPointType {
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        /*
             https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyBssu0RxPm7XLDG7gzrPrRACs0ojsy6vw8
             
             https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&type=museum&key=AIzaSyBssu0RxPm7XLDG7gzrPrRACs0ojsy6vw8
             
             https://maps.googleapis.com/maps/api/place/radarsearch/json?location=48.859294,2.347589&radius=5000&type=cafe&keyword=vegetarian&key=AIzaSyBssu0RxPm7XLDG7gzrPrRACs0ojsy6vw8
             
             https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&rankby=distance&types=food&key=AIzaSyBssu0RxPm7XLDG7gzrPrRACs0ojsy6vw8
             
             https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=CpQCAgEAAFxg8o-eU7_uKn7Yqjana-HQIx1hr5BrT4zBaEko29ANsXtp9mrqN0yrKWhf-y2PUpHRLQb1GT-mtxNcXou8TwkXhi1Jbk-ReY7oulyuvKSQrw1lgJElggGlo0d6indiH1U-tDwquw4tU_UXoQ_sj8OBo8XBUuWjuuFShqmLMP-0W59Vr6CaXdLrF8M3wFR4dUUhSf5UC4QCLaOMVP92lyh0OdtF_m_9Dt7lz-Wniod9zDrHeDsz_by570K3jL1VuDKTl_U1cJ0mzz_zDHGfOUf7VU1kVIs1WnM9SGvnm8YZURLTtMLMWx8-doGUE56Af_VfKjGDYW361OOIj9GmkyCFtaoCmTMIr5kgyeUSnB-IEhDlzujVrV6O9Mt7N4DagR6RGhT3g1viYLS4kO5YindU6dm3GIof1Q&key=AIzaSyBssu0RxPm7XLDG7gzrPrRACs0ojsy6vw8
        */
        case .production: return "http://localhost:3003"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseUrl) else { fatalError("baseUrl could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "/json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    
    var task: HTTPTask {
        switch self {
        case .users:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}

