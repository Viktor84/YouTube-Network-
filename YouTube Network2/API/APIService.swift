//
//  APIService.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//
// BUNDLE_ID com.example.Viktor.YouTube-Network2


import Foundation
import Alamofire

class APIService {
    
    static let sharedInstance = APIService()
    
    private var manager: SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.httpShouldSetCookies = false
        manager = SessionManager(configuration: configuration)
    }
    
    //private let appID = "AIzaSyCbVfMWTxgGIJBa6uncFakrHpeKReNmksg"
    //private let baseUrl = "https://www.googleapis.com/youtube"
    //let url = baseUrl + "/v3/search?part=snippet&maxResults=25&q=surfing&type=video&key=\(appID)"
    
    func getAPI( completion: @escaping (_ result: JSONResponse?) -> Void) {
        let endpoint = Endpoint.getAPI
        
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default)
            .responseData { response in
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else {
                        completion(nil)
                        return
                    }
                    let firsResponse: JSONResponse = try decoder.decode(JSONResponse.self, from: data)
                    print("JSON Data: ", firsResponse)
                    completion(firsResponse)
                } catch {
                    completion(nil)
                }
        }
    }
    
    private let accessToken = "667764541707-u1qs4quiupj3qj9oqkrvg9tr6i587j5v.apps.googleusercontent.com"
   
}
