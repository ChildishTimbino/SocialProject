//
//  ViewController.swift
//  SocialProject
//
//  Created by Timothy Hull on 3/3/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare


let facebookColor = UIColor(hexString: "#3B5998")
let twitterColor = UIColor(hexString: "#00aced")
let loginController = LoginController()
let shareController = ShareController()


class LoginController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = twitterColor

        // Login Button
        var loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton = LoginButton(publishPermissions: [ .publishActions ])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
        view.addSubview(tttLogo)
        setuptttLogo()
        
        // Go straight to shareController if user is already logged in when app is launched
        if AccessToken.current != nil {
            self.view.addSubview(returnToShareButton)
            setupReturnToShareButton()
            self.present(shareController, animated: true, completion: nil)
        }
        

        
    }
    
    
    
    
    // Present shareController upon successful login
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        self.view.addSubview(returnToShareButton)
        setupReturnToShareButton()
        self.present(shareController, animated: true, completion: nil)
    }
    
    // Logout
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        self.returnToShareButton.removeFromSuperview()
        print("User Logged Out")
    }

    // Go back to the share screen if you're already logged in
    func returnToShare() {
        self.present(shareController, animated: true, completion: nil)
    }




    
// MARK: - Views
    
    lazy var tttLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TTTdude")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var returnToShareButton: UIButton = {
        let bButton = UIButton(type: .system)
        bButton.backgroundColor = facebookColor
        bButton.layer.borderWidth = 1
        bButton.layer.borderColor = UIColor.white.cgColor
        bButton.setTitle("Return to Share", for: UIControlState())
        bButton.translatesAutoresizingMaskIntoConstraints = false
        bButton.setTitleColor(UIColor.white, for: UIControlState())
        bButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        bButton.addTarget(self, action: #selector(returnToShare), for: .touchUpInside)
        
        return bButton
    }()

    
    
    
// MARK: - Constraints
    
    func setuptttLogo() {
        tttLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tttLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        tttLogo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        tttLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupReturnToShareButton() {
        returnToShareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 75).isActive = true
        returnToShareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280).isActive = true
        returnToShareButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        returnToShareButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }


    
    
    
    

    
}
    






