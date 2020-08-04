//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/5/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }

    var userName: String!
    
    var followers: [Follower] = []
    var filterFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for username"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingview()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            // allows for "?" not be after self.
            guard let self = self else {return}
              self.dismissLoadingview()
               switch result {
               case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let messeage = "This user does not have any followers. Go follow them 🤯."
                    DispatchQueue.main.async { self.showEmptyStateView(with: messeage, in: self.view) }
                    return
                }
                self.updateData(on: self.followers)
               case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Test", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexpath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true, completion: nil) }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contenHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contenHeight - height {
            guard hasMoreFollowers else { return }
            //if call is made page number goes up
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        // guard let is making sure the search bar is not empty
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filterFollowers)
    }
    
    // use orginal array of followers when cancel is tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
