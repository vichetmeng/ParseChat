//
//  Message.swift
//  ParseChat
//
//  Created by Vichet Meng on 10/30/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    
    @NSManaged var content: String
    @NSManaged var author: PFUser
    
    static func parseClassName() -> String {
        return "Message"
    }
    
    class func pushMessage(_ messageContent:String) {
        let message = Message()
        message.content = messageContent
        message.author = PFUser.current()!
        message.saveInBackground(){(success, error) in
            if success {
                print("Message was saved!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
        
}
