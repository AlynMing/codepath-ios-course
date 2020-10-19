//
//  LoginViewController.swift
//  instagram
//
//  Created by Chukwubuikem Ume-Ugwa on 10/19/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = self.username.text!
        let password = self.password.text!
        
        PFUser.logInWithUsername(inBackground: username
                                 , password: password, block: {
                                    (user, error) in
                                    if user != nil{
                                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                    }
                                 })
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        
        user.signUpInBackground{
            (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error \(String(describing: error))")
            }
        }
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
