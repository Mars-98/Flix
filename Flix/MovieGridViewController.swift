//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Mariam Adams on 9/28/20.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //spacing between each row
        layout.minimumLineSpacing = 0
        //column sizing, causes image wraping to occur
        layout.minimumInteritemSpacing = 0
        //subtracting layout.minimumInteritemSpacing to take into account how much space we put in between the images
        let width = (view.frame.size.width - layout.minimumInteritemSpacing)/2
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error)
            in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                print(self.movies)
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w780"
        
     //check if the movie contains an image
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: baseUrl + posterPath)!
            cell.posterView.af.setImage(withURL: posterUrl)
        }
        else {
           // No poster image. Can either set to nil (no image) or a default movie poster image
           // that you include as an asset
           cell.posterView.image = nil
        }
        
        return cell
    }
}
