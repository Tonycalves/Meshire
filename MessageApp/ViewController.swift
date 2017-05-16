//
//  ViewController.swift
//  MessageApp
//
//  Created by Anthony Goncalves on 14/02/2017.
//  Copyright © 2017 Anthony Goncalves. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var uiimgprofile: UIImageView!
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var labelprofile: UILabel!
    var imageView: UIImageView!
    var label: UILabel!
    let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnMenuButton.target = SWRevealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 120, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        
        // Profil
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        imageView.center = CGPoint(x: view.center.x, y: 280)
        imageView.image = UIImage(named: "logofb")
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.cornerRadius = 70
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        label.center = CGPoint(x: view.center.x, y: 380)
        label.text = "Not Logged In"
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        
        getFacebookUserInfo()
    }

    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                self.label.text = data["name"] as? String
                let FBid = data["id"] as? String
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imageView.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
        imageView.image = UIImage(named: "logofb")
        label.text = "Not Logged In"
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("didCompleteWith")
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("User logged to firebase successfully")
            if let error = error {
                print(error)
            }
            }
        getFacebookUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
