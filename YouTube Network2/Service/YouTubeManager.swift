//
//  YouTubeService.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 01.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Google
import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class YouTubeManager: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    static let sharedInstance = YouTubeManager()
    private let youTubeFunction = YouTubeFunction.sharedInstance
    
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    private let service = GTLRYouTubeService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeYouTube, kGTLRAuthScopeYouTubeUpload]
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().signInSilently()
        view.addSubview(signInButton)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            
            youTubeFunction.delegate = self
        }
    }
    
    @objc func displayResultWithTicket(
        ticket: GTLRServiceTicket,
        finishedWithObject response : GTLRYouTube_ChannelListResponse,
        error : NSError?) {

        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }

        print("google response: ", response)
        var outputText = ""
        if let channels = response.items, !channels.isEmpty {
            let channel = response.items![0]
            let title = channel.snippet!.title
            let description = channel.snippet?.descriptionProperty
            let viewCount = channel.statistics?.viewCount
            outputText += "title: \(title!)\n"
            outputText += "description: \(description!)\n"
            outputText += "view count: \(viewCount!)\n"
        }
        output.text = outputText
    }
    
    func uploadVideo() {
        var configureError: NSError?
        
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        service.authorizer = GIDSignIn.sharedInstance().currentUser.authentication.fetcherAuthorizer()
        
        let status = GTLRYouTube_VideoStatus()
        status.privacyStatus = kGTLRYouTube_VideoStatus_PrivacyStatus_Public
        
        let snippet = GTLRYouTube_VideoSnippet()
        snippet.title = "ZX23841"
        snippet.descriptionProperty = "TestUpload"
        snippet.tags = "test,video,upload".components(separatedBy: ",")
        
        let youtubeVideo = GTLRYouTube_Video()
        youtubeVideo.snippet = snippet
        youtubeVideo.status = status
        
        
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        print("Current path: \(currentPath)")
        let path = "file:///Users/viktorpechersky/Desktop/videoTest.mp4"
        
        guard let url = URL(string: path) as? URL else {
            return
        }
    
        let uploadParams = GTLRUploadParameters(fileURL: url, mimeType: "video/mp4")
        
        let uploadQuery = GTLRYouTubeQuery_VideosInsert.query(withObject: youtubeVideo, part: "snippet,status", uploadParameters: uploadParams)
        
        uploadQuery.executionParameters.uploadProgressBlock = {(progressTicket, totalBytesUploaded, totalBytesExpectedToUpload) in
            print("Uploaded", totalBytesUploaded)
        }
        
        service.executeQuery(uploadQuery) { (ticket, obj, error) in
            print("ticket: ",ticket)
            print("obj: ",obj)
            print("error: ",error)
        }
    }
    
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension YouTubeManager: YouTubeFunctionDelegate {
    func doDisplayResultWithTicket(ticket: GTLRServiceTicket, finishedWithObject response: GTLRYouTube_ChannelListResponse, error: NSError?) {
        
        displayResultWithTicket(ticket: ticket, finishedWithObject: response, error: error)
    }
}
