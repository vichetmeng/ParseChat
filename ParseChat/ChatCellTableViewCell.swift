//
//  ChatCellTableViewCell.swift
//  ParseChat
//
//  Created by Vichet Meng on 10/30/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bubbleView.layer.cornerRadius = 16
        self.bubbleView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
