//
//  Endpoint.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case getAPI
    
    var method: HTTPMethod {
        switch self {
        case .getAPI:
            return .get
        }
    }
    
    var url: String {
        let appID = "AIzaSyBSMDI5OelSmiHZO7ZGGsKTR245uqxmeKM"
        let baseUrl = "https://www.googleapis.com/"
        switch self {
        case .getAPI:
            return baseUrl + "/youtube/v3/search?part=snippet&maxResults=25&q=surfing&type=video&key=\(appID)"
        }
    }
}

