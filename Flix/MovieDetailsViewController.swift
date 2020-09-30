//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Mariam Adams on 9/28/20.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        summaryLabel.text = movie["overview"] as? String
        summaryLabel.sizeToFit()
        releaseDateLabel.text = movie["release_date"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        
        //check if the movie contains an image
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: baseUrl + posterPath)!
            posterView.af.setImage(withURL: posterUrl)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            posterView.image = nil
        }
        
        if let backdropPath = movie["backdrop_path"] as? String {
            let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
            backdropView.af.setImage(withURL: backdropUrl)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            backdropView.image = nil
        }
        
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
