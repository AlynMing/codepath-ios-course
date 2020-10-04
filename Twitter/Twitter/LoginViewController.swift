//
//  LoginViewController.swift
//  Twitter
//
//  Created by Chukwubuikem Ume-Ugwa on 10/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let key = "user-logged-in"
    let segueId = "loginToHome"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: self.key) == true{            
            self.performSegue(withIdentifier: self.segueId, sender: self)
        }
    }

    @IBAction func onLoginButton(_ sender: Any) {
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: self.key)
            self.performSegue(withIdentifier: self.segueId, sender: self)
        }, failure: { (Error) in
            print("Log in failed")
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
