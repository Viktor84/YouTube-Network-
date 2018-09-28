//
//  UploadVideoViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Google
import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class UploadVideoViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBAction func upload(_ sender: Any) {
        uploadVideo()
    }
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    private let service = GTLRYouTubeService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().scopes = scopes
 
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeYouTube, kGTLRAuthScopeYouTubeUpload]
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
         //       GIDSignIn.sharedInstance().signIn()
        
        GIDSignIn.sharedInstance().signInSilently()

        // Add the sign-in button.
        view.addSubview(signInButton)

        // Add a UITextView to display output.
//        output.frame = view.bounds
//        output.isEditable = false
//        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        output.isHidden = true
//        view.addSubview(output);
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
            fetchChannelResource()
        }
    }
    
    // List up to 10 files in Drive
    func fetchChannelResource() {
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
        query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
        // To retrieve data for the current user's channel, comment out the previous
        // line (query.identifier ...) and uncomment the next line (query.mine ...)
        // query.mine = true
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    // Process the response and display output
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
        
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeYouTube, kGTLRAuthScopeYouTubeUpload]
//        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
//        GIDSignIn.sharedInstance().signIn()
//
       service.authorizer = GIDSignIn.sharedInstance().currentUser.authentication.fetcherAuthorizer()
        
        let status = GTLRYouTube_VideoStatus()
        status.privacyStatus = kGTLRYouTube_VideoStatus_PrivacyStatus_Public
        
        let snippet = GTLRYouTube_VideoSnippet()
        //snippet.title = "ZX2384" 1 version
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
        //let path = "file:///Users/svitlanamoiseyenko/Desktop/video.mp4" 1 version
        
        guard let url = URL(string: path) as? URL else {
            return
        }
//        guard let videodata = NSData(contentsOf: url as URL) as? NSData else {
//            return
//        }
//        guard let vdata = Data(referencing: videodata) as? Data else {
//            return
//        }
//        
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
    
    // Helper for showing an alert
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



