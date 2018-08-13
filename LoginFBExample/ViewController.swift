//
//  ViewController.swift
//  LoginFBExample
//
//  Created by Le Tien An on 8/13/18.
//  Copyright © 2018 Le Tien An. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userProfileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile","email"]
        self.view.addSubview(loginButton)
        userFullName.text = ""
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKProfileDidChange, object: nil, queue: OperationQueue.main, using: { notification in
            if let profile = FBSDKProfile.current() {
                // Update for new user profile
                if let fullName = profile.name {
                    self.userFullName.text = fullName
                }
                let profilePictureView = FBSDKProfilePictureView()
                profilePictureView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                profilePictureView.profileID = FBSDKAccessToken.current().userID
                self.userProfileView.addSubview(profilePictureView)
            }
        })
    }
}

