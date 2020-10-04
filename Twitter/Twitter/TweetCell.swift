//
//  TweetCell.swift
//  Twitter
//
//  Created by Chukwubuikem Ume-Ugwa on 10/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
