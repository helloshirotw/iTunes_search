//
//  UIApplication.swift
//  PodcastsDemo
//
//  Created by gary chen on 2018/7/22.
//  Copyright © 2018年 Gary Chen. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}

