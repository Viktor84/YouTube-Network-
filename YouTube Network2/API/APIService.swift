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
    // postVideoToYouTube(token: accessToken, callback: { success in
    //     if success { }
    // })
    func postVideoToYouTube(){
        let endpoint = Endpoint.postVideoToYouTube
        
        let headers = ["Authorization": "Bearer \(accessToken)"]
        
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        print("Current path: \(currentPath)")
        //let path = "file:///Users/viktorpechersky/Desktop/video.mp4"
        let path = "file:///Users/svitlanamoiseyenko/Desktop/video.mp4"
        
        guard let url = URL(string: path) as? URL else {
            return
        }
        guard let videodata = NSData(contentsOf: url as URL) as? NSData else {
            return
        }
        guard let vdata = Data(referencing: videodata) as? Data else {
            return
        }
        print("vdata: \(vdata)")
        
        //        let params: [String: Any] = ["data": videodata,
        //                      "name": "video 777",
        //                      "fileName": "video.mp4",
        //                      "mimeType": "video/*",
        //                      "part": "snippet,status"] as [String : Any]
        //        Alamofire.request(endpoint.url, method: endpoint.method, parameters: params, headers: headers)
        //        .responseJSON { response in
        //            print("response: ", response)
        //        }
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
           // multipartFormData.append("{'snippet':{'title' : 'TITLE_TEXT', 'description': 'DESCRIPTION_TEXT'}}".data(using: .utf8, allowLossyConversion: false)!, withName: "snippet", mimeType: "application/json")
            multipartFormData.append(vdata, withName: "video", fileName: "video.mp4", mimeType: "application/octet-stream")
        }, to: endpoint.url,
           headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _ , _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("uploding")
                })
                
                upload.responseJSON { response in
                    print("done: ", response)
                }
                
            case .failure(let encodingError):
                print("failed")
                print(encodingError)
                
            }
        }
    }
}
