//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Chukwubuikem Ume-Ugwa on 9/28/20.
//

import UIKit
import AlamofireImage
class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!    
    @IBOutlet weak var overview: UILabel!
    
    var movie : [String : Any]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        overview.text = movie!["overview"] as? String
        movieTitle.text = movie!["title"] as? String
        
        
        var url = "https://image.tmdb.org/t/p/w185" + (movie!["poster_path"] as! String)
        poster.af.setImage(withURL: URL(string: url)!)
        
        url = "https://image.tmdb.org/t/p/w780" + (movie!["backdrop_path"] as! String)
        backdrop.af.setImage(withURL: URL(string: url)!)
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.movieId = self.movie!["id"] as? Int
    }
    

}
