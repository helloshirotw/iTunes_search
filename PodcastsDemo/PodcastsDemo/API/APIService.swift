//
//  APIService.swift
//  PodcastsDemo
//
//  Created by Gary Chen on 25/5/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    //singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl ) else { return }
        
        //Fetch api in background thread for not locking UI
        
        DispatchQueue.global(qos: .background).async {
            
            let parser = FeedParser(URL: url)
            
            parser?.parseAsync(result: { (result) in
                print("Successfully parse feed:", result.isSuccess)
                
                if let err = result.error {
                    print("Failed to parse XML feed:", err)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            })
        }
        
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        print("Searching for podcasts...")
        
        // Implement Alamofire to search iTunes API
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                print(searchResult.resultCount)
                
                completionHandler(searchResult.results)
                
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
    
}

struct SearchResults: Decodable {
    let resultCount : Int
    let results: [Podcast]
}

