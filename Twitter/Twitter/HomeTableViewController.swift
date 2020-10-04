//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Chukwubuikem Ume-Ugwa on 10/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let key = "user-logged-in"
    
    var tweets = [NSDictionary]()
    var numberOfTweets: Int!
    let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    
    let tweetRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        tweetRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = tweetRefreshControl
    }

    @objc func loadTweets() -> Void {
        numberOfTweets = 20
        let params = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweets{
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            self.tweetRefreshControl.endRefreshing()
            
        }, failure: { (error: Error) in
            print("Encounter an error \(error.localizedDescription)")
        })
    }
    
    func loadMoreTweets() -> Void{
        numberOfTweets += 20
        let params = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweets{
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Encounter an error \(error.localizedDescription)")
        })
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.setValue(false, forKey: self.key)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let user = tweets[indexPath.row]["user"] as! NSDictionary
        cell.username.text = user["name"] as? String
        cell.tweetContent.text = tweets[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: user["profile_image_url_https"] as! String)!
        let data = try? Data(contentsOf: imageUrl)
        if let imageData = data{
            cell.profilePicture.image = UIImage(data: imageData)
        }
        
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count{
            loadMoreTweets()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }



}
