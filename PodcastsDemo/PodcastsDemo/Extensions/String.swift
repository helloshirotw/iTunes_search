//
//  String.swift
//  PodcastsDemo
//
//  Created by Gary Chen on 27/5/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self: self.replacingOccurrences(of: "http", with: "https")
    }
}
