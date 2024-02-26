//
//  MovieCell.swift
//  FlixsterPt2
//
//
//  Created by Augusto Rodriguez on 10/1/23.
//

import UIKit

import Nuke
class MovieCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    func configure(with movie: Movie) {
        movieNameLabel.text = movie.original_title
        movieOverviewLabel.text = movie.overview
        
        Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path)!, into: movieImageView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
