//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage_View: UIView!
    
    @IBOutlet weak var movie_img: UIImageView!
    
    @IBOutlet weak var MovieName_lbl: UILabel!
    
    @IBOutlet weak var MovieGenre_lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage_View.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
