//
//  APIService.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation

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
    
    private let accessToken = "42432162847-tp6fdq24tfeiceib7msr4smnmr5e1prl.apps.googleusercontent.com"
    // postVideoToYouTube(token: accessToken, callback: { success in
    //     if success { }
    // })
    func postVideoToYouTube(){
        let endpoint = Endpoint.postVideoToYouTube
        
        let headers = ["Authorization": "Bearer ya29.GlsaBsLwv1t_oL62kkwyZNEwXtehDyn9iwlg-JuCidJxVV5hqq7vWZW1eLnLPxBgAuch0z_1VE9zNcbAzOrpMhfs2bMRpj5hkemYjSlUazDfGt9_j9569gYJpXOE"]
        
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        print("Current path: \(currentPath)")
        let path = "file:///Users/viktorpechersky/Desktop/video.mp4"
        //"file:///Users/svitlanamoiseyenko/Downloads/YN/YN/YN/video.mp4" /Users/viktorpechersky/Desktop //currentPath + "video.mp4"
        
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
            //          multipartFormData.append("{'snippet':{'title' : 'TITLE_TEXT', 'description': 'DESCRIPTION_TEXT'}}".data(using: .utf8, allowLossyConversion: false)!, withName: "snippet", mimeType: "application/json")
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
