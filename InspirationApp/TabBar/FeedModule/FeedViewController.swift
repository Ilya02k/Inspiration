//
//  FeedViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, PresenterDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    let cellId = "cell"
    let presenter = Presenter(service: .init(session: .shared))
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        if self.presenter.dataSource[indexPath.row].image == nil {
            
            self.presenter.getImage(urlByImage: URL(string: self.presenter.dataSource[indexPath.row].urls.regular)) { [weak self] (responseImage) in
                self?.presenter.dataSource[indexPath.row].image = responseImage
                
            }
        }
        
        cell.configureCell(model: self.presenter.dataSource[indexPath.row] )
        
        self.tableView.reloadRows(at: [indexPath], with: .none)
        cell.configureSaveButton()
        cell.saveBlock = { [weak self]
            in
            var item = cell.post
            if item?.isFavorite == true {
                item = self?.presenter.removeFromCoreData(item: &cell.post!)
            }
            else {
                item = self?.presenter.saveToCoreData(item: &cell.post!)
            }
        }
        return cell
    }
    
    //MARK: Infinity Scrolling
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let actualPosition = scrollView.contentOffset.y
        
        let contentHeight = scrollView.contentSize.height - (tableView.frame.size.height)
        
        if (actualPosition >= contentHeight) {
            self.presenter.getData {
                self.tableView.reloadData()
            }
        }
    }
    //MARK: setup
    func setup() -> () {
        view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.presenter.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        //
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        //
        self.presenter.getData {
            self.tableView.reloadData()
        }
    }
    
    //MARK:  life cycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    
    
    func showError(error: Error) {
        print(error)
    }
    
}
