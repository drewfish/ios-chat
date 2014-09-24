//
//  ViewController.swift
//  chat
//
//  Created by Andrew Folta on 9/23/14.
//  Copyright (c) 2014 Andrew Folta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailField.text, password: passwordField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                // TODO
                println(user)
            } else {
                println(error)
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        user.email = emailField.text

        user.signUpInBackgroundWithBlock() {
            (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                // TODO
            } else {
                println(error)
            }
        }
    }
}

