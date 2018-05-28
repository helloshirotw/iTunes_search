//
//  EpisodeCell.swift
//  PodcastsDemo
//
//  Created by Gary Chen on 27/5/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title.description
            descriptionLabel.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
            
            let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "")
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}
