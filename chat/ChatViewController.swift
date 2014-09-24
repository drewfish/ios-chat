//
//  ChatViewController.swift
//  chat
//
//  Created by Andrew Folta on 9/23/14.
//  Copyright (c) 2014 Andrew Folta. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet var messageList: UITableView!

    var messages: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        messageList.delegate = self
        messageList.dataSource = self

        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
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
            } else {
                println("-- message FAILED to submitted")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }

    func onTimer() {
        var query = PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock() {
            (objects: [AnyObject]!, error: NSError?) -> Void in
            if error == nil {
                self.messages = []
                for object in objects {
                    var message = object as PFObject
                    var s = message["text"] as String
                    self.messages.append(s)
                }
                self.messageList.reloadData()
            } else {
                println(error)
            }
        }
    }
}
