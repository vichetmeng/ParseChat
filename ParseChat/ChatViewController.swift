//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Vichet Meng on 10/30/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages:[PFObject]? {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func onSend(_ sender: Any) {
        if messageTextField.text != "" {
            Message.pushMessage(messageTextField.text ?? "")
        }
    }
    
    // MARK: - UITableView delegate and methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Row Count: \(messages?.count ?? 0)")
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCellTableViewCell
        if let messages = self.messages {
            let content = (messages[indexPath.row] as! Message).content
            if content != "" {
                cell.messageLabel.text = content
                cell.authorLabel.text = (messages[indexPath.row] as! Message).author.username ?? "🤖"
            } else {
                cell.messageLabel.text = ""
                cell.authorLabel.text = ""
                //cell.bubbleView.backgroundColor = UIColor.clear
            }
        }
        
        return cell
    }
    
    
    // MARK: - Helper methods
    @objc func onTimer () {
        let query = Message.query()
        query?.limit = 20
        query?.addDescendingOrder("createdAt")
        query?.includeKey("author")
        
        query?.findObjectsInBackground(block: { (messages:[PFObject]?, error:Error?) in
            if let messages = messages {
                self.messages = messages
            } else {
                if let error = error {
                    print("Error fetching messages: " + error.localizedDescription)
                }
            }
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
