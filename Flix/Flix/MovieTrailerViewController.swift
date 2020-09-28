//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Chukwubuikem Ume-Ugwa on 9/28/20.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController , WKUIDelegate{
    
    var webView: WKWebView!
    var movieId: Int!
               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url =  URL(string: "https://api.themoviedb.org/3/movie/\(movieId!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { [self] (data, response, error) in
           if let error = error {
                print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let movies = dataDictionary["results"] as! [[String:Any]]
                let key = movies[0]["key"]
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(key!)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)

           }
        }
        task.resume()

    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
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
