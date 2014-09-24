//
//  ChatViewController.swift
//  chat
//
//  Created by Andrew Folta on 9/23/14.
//  Copyright (c) 2014 Andrew Folta. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var messageField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSend(sender: AnyObject) {
        var message = PFObject(className: "Message")
        message["text"] = messageField.text
        message.saveInBackgroundWithBlock {
            (block: Bool?, error: NSError?) in
            if error == nil {
                println("-- message successfully submitted")
            }
            else {
                println("-- message FAILED to submitted")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
