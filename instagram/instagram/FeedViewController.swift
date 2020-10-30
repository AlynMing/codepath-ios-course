//
//  FeedViewController.swift
//  instagram
//
//  Created by Chukwubuikem Ume-Ugwa on 10/19/20.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate{
    var posts = [PFObject]()
    @IBOutlet weak var tableView: UITableView!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.keyboardDismissMode = .interactive
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(hideKeyBoard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        commentBar.inputTextView.placeholder = "Add a comment ..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
        
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["author"] = PFUser.current()!
        comment["post"] = selectedPost
        selectedPost.add(comment, forKey: "comments")
        selectedPost.saveInBackground{
            (success, error) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func hideKeyBoard(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
            

            let user = post["author"] as! PFUser
            cell.username.text = user["username"] as? String
            cell.caption.text = post["caption"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let url = URL(string: imageFile.url!)
            
            cell.photoView.af.setImage(withURL: url!)
            return cell
            
        }else if indexPath.row <= comments.count && comments.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
                        
            let comment = comments[indexPath.row - 1]
            let user = comment["author"] as! PFUser
            cell.username.text = user["username"] as? String
            cell.comment.text = comment["text"] as? String
            return cell
            
        }else{
            return  tableView.dequeueReusableCell(withIdentifier: "addCommentCell")!
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        
        let comments = (post["comments"] as? [PFObject]) ?? []
        if indexPath.row == comments.count + 1 {
            selectedPost = post
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
    }

    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let login = main.instantiateViewController(withIdentifier: "loginViewController")
        
        let delegate = view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = login
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
