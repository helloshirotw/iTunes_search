//
//  Podcast.swift
//  PodcastsDemo
//
//  Created by Gary Chen on 24/5/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}

