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
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteTweet: UIButton!
    private var _fav = false
    private var _retweeted = false
    var tweetId: Int = -1
    
    var favorited:Bool {
        get{
            return _fav
        }
        set(val){
            _fav = val
            if val {
                favoriteTweet.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            }else{
                favoriteTweet.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            }
        }
    }
    
    var retweeted: Bool{
        get{
            return _retweeted
        }
        set(val){
            _retweeted = val
            if val {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
                retweetButton.isEnabled = false
            }else{
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
                retweetButton.isEnabled = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFavorite(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if toBeFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {self.favorited = true}, failure: {
                (error) in
                print("favorite did not succeed")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetId, success: {self.favorited = false}, failure: {
                (error) in
                print("unfavorite did not succeed")
            })
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetID: tweetId, success: {self.retweeted = true}, failure: {
            (error) in
            print("favorite did not succeed")
        })
    }
}
