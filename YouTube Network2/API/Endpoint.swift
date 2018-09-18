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
    case postVideoToYouTube
    
    var method: HTTPMethod {
        switch self {
        case .getAPI:
            return .get
        case .postVideoToYouTube:
            return .post
        }
    }
    
    var url: String {
        let appID = "AIzaSyBSMDI5OelSmiHZO7ZGGsKTR245uqxmeKM"
        let baseUrl = "https://www.googleapis.com/"
        switch self {
        case .getAPI:
            return baseUrl + "/youtube/v3/search?part=snippet&maxResults=25&q=surfing&type=video&key=\(appID)"
        case .postVideoToYouTube:
            return baseUrl + "/upload/youtube/v3/videos?part=snippet" //"/upload/youtube/v3/videos?part=id"
        }
    }
}

/*
 POST /youtube/v3/videos?part=snippet HTTP/1.1
 Host: www.googleapis.com
 Content-length: 666941
 Content-type: video/mp4
 Authorization: Bearer ya29.GlsaBsLwv1t_oL62kkwyZNEwXtehDyn9iwlg-JuCidJxVV5hqq7vWZW1eLnLPxBgAuch0z_1VE9zNcbAzOrpMhfs2bMRpj5hkemYjSlUazDfGt9_j9569gYJpXOE
 
 */
