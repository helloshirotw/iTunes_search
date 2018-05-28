//
//  PodcastsSearchController.swift
//  PodcastsDemo
//
//  Created by Gary Chen on 24/5/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController {
    
    var podcasts = [Podcast]()
    
    let cellId = "cellId"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
        episodesController.podcast = podcasts[indexPath.row]
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.podcasts.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PODCAST_CELL, for: indexPath) as! PodcastCell
        
        let podcast = podcasts[indexPath.row]
        cell.podcast = podcast

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    //MARK:- Setup Work
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: Constants.PODCAST_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.PODCAST_CELL)
    }
    
}

//MARK:- UISearchBarDelegate

extension PodcastsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
    }
}

