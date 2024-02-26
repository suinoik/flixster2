//
//  DetailViewController.swift
//  FlixsterPt2
//
//
//  Created by Augusto Rodriguez on 10/1/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    
    var movie: Movie!
    
    @IBOutlet weak var back_drop_image: UIImageView!
    
    @IBOutlet weak var movie_title: UILabel!
    
    
    @IBOutlet weak var average_votes: UILabel!
    
    @IBOutlet weak var total_votes: UILabel!
    
    
    @IBOutlet weak var popularity: UILabel!
    
    
    @IBOutlet weak var movie_overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
                    
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
       
        Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w185" + movie.poster_path)!, into: back_drop_image)
           
        movie_title.text = movie.original_title
                
        average_votes.text = String(format: "%.2f Vote Average", movie.vote_average)
                
        popularity.text = String(format: "%.2f Popularity", movie.popularity)
                
        total_votes.text = String(format:"%d Votes", movie.vote_count)
                
        movie_overview.text = movie.overview
         
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
