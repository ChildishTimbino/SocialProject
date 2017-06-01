//
//  ShareController.swift
//  SocialProject
//
//  Created by Timothy Hull on 3/3/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import UIKit
import FacebookShare
import FacebookCore
import FacebookLogin

class ShareController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let loginController = LoginController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = twitterColor
        self.navigationController?.isNavigationBarHidden = true
        
        view.addSubview(facebookShareButton)
        view.addSubview(emailLabel)
        view.addSubview(nameLabel)
        view.addSubview(backButton)
        setupBackButton()
        setupNameLabel()
        setupEmailLabel()
        setupFacebookShareButton()

        getUserInfo()
    }
    
    
    
    
    // Grab FB info with graph request
    func getUserInfo() {
        let params = ["fields" : "email, name"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    
                    if let name = responseDictionary["name"] {
                        self.nameLabel.text = "Logged in as: \n\(name)"
                    }
                    
                    if let email = responseDictionary["email"] {
                        self.emailLabel.text = "Your email is: \n\(email)"
                    } else {
                        self.emailLabel.text = "Your email is: "
                    }
                    print(responseDictionary["name"])
                    print(responseDictionary["email"])
                }
            }
        }
    }
    
    
    
    
    // Choose Image/FB Share dialog
    func share() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        let photo = Photo(image: image, userGenerated: true)
        let content = PhotoShareContent(photos: [photo])
        
        do {
            try ShareDialog.show(from: shareController, content: content)
            dismiss(animated: true, completion: nil)
        } catch (let error) {
            print("Invalid share content. Failed to present share dialog with error \(error)")
        }
    }
    
    


    
    
    // Handle IPC cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    // Back button
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
// MARK: - Views
    
    lazy var facebookShareButton: UIButton = {
        let fbButton = UIButton(type: .system)
        fbButton.backgroundColor = facebookColor
        fbButton.layer.borderWidth = 1
        fbButton.layer.borderColor = UIColor.white.cgColor
        fbButton.setTitle("Share a Photo", for: UIControlState())
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.setTitleColor(UIColor.white, for: UIControlState())
        fbButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        fbButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        return fbButton
    }()
    
    let emailLabel: UILabel = {
        let frame = CGRect(x: 100, y: 100, width: 400, height: 200)
        let label = UILabel(frame: frame)
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let frame = CGRect(x: 100, y: 100, width: 400, height: 200)
        let nLabel = UILabel(frame: frame)
        nLabel.textAlignment = NSTextAlignment.center
        nLabel.text = ""
        nLabel.numberOfLines = 2
        nLabel.textColor = UIColor.black
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nLabel
    }()
    
    lazy var backButton: UIButton = {
        let bButton = UIButton(type: .system)
        bButton.backgroundColor = facebookColor
        bButton.layer.borderWidth = 1
        bButton.layer.borderColor = UIColor.white.cgColor
        bButton.setTitle("<-- Back to Login", for: UIControlState())
        bButton.translatesAutoresizingMaskIntoConstraints = false
        bButton.setTitleColor(UIColor.white, for: UIControlState())
        bButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        bButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return bButton
    }()
    
    

    
    

// MARK: - Constraints
    
    func setupFacebookShareButton() {
        facebookShareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookShareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        facebookShareButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        facebookShareButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    func setupEmailLabel() {
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 73).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 73).isActive = true
    }
    
    func setupBackButton() {
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75).isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    
    
    
}
