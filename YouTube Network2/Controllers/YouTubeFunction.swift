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

class YouTubeFunction: YouTubeManager {
    
    private let service = GTLRYouTubeService()

func fetchChannelResource() {
    let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
    
    query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
    service.executeQuery(query,
                         delegate: self,
                         didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
}
