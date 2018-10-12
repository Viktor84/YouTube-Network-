//
//  YouTubeFunction.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 05.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import Google
import GoogleAPIClientForREST
import GoogleSignIn

protocol YouTubeFunctionDelegate {
    func doDisplayResultWithTicket(ticket: GTLRServiceTicket,
                                   finishedWithObject response : GTLRYouTube_ChannelListResponse,
                                   error : NSError?)
}

class YouTubeFunction {
    
    static let sharedInstance = YouTubeFunction()
    private let service = GTLRYouTubeService()
    var delegate: YouTubeFunctionDelegate?
  
    
    private init() {}
 
    func fetchChannelResource(vc: UploadVideoViewController) {
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
    
        query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
        service.executeQuery(query,
                         delegate: vc,
                         didFinish: #selector(YouTubeFunction.handleResult(ticket:finishedWithObject:error:)))
    }
    
    @objc func handleResult(ticket: GTLRServiceTicket,
                      finishedWithObject response : GTLRYouTube_ChannelListResponse,
                      error : NSError?) {
        delegate?.doDisplayResultWithTicket(ticket: ticket, finishedWithObject:response, error: error)
    }
}
