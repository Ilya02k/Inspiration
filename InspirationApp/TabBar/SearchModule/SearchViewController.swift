//
//  SearchViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, FeedPresenterDelegate {
    

    var searchController = UISearchController()
    let searchResultController = SearchResultViewController()
    let presenter = FeedPresenter(service: .init(session: .shared))
    var searchDataSource = [AdvancedPhotoModel]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController.init(searchResultsController: self.searchResultController)
       // searchResultController.dataSource = self.searchDataSource
        self.presenter.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        self.navigationItem.searchController = searchController
        self.setup()

        
    }
    
    func setup() -> () {
        //label
    }
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchController.searchBar)
           perform(#selector(self.reload(_:)), with: searchController.searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        self.presenter.getSearchData(query: query) {
            DispatchQueue.main.async {
                [weak self] in
                self?.searchDataSource.removeAll()

                self?.searchResultController.dataSource = (self?.presenter.dataSource)!
                self?.searchResultController.tableView.reloadData()
            }
        }

        print(query)
    }
    
    func showError(error: Error) {
         print(error)
    }


}
