//
//  CMTime.swift
//  PodcastsDemo
//
//  Created by gary chen on 2018/7/10.
//  Copyright © 2018年 Gary Chen. All rights reserved.
//

import AVKit

extension CMTime {
    func toDisplayString() -> String {
        
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        
        return timeFormatString
    }
}
