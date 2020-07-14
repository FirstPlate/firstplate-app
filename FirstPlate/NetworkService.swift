//
//  NetworkService.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 21/06/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "JqQQR4lrXFzFKrhMtKMFBDZyZFyDtZPe4_TsMe2yQnxbHf1Rc8j11me3bKaFnyBaXwlkTaxmp5ixtUyEmXFFg8JE9v7OHBGyVR1FthjfipCX4QM7ZEl8CtuGsKPvXnYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        case details(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 25], encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
