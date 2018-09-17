//
//  JSONRespone.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation

struct JSONResponse: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let pageInfo: JSONPage
    let items: [JSONItems]
}

struct JSONPage: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct JSONItems: Codable {
    let kind: String
    let etag: String
    let id: JSONId
    let snippet: JSONSnippet
}

struct JSONId: Codable {
    let kind: String
    let videoId :String
}

struct JSONSnippet: Codable {
    
    let channelId: String
}
