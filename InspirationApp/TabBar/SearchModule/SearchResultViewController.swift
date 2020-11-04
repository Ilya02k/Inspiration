//
//  SearchResultViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/18/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: Properties
    let cellId = "cell"
    var dataSource = [AdvancedPhotoModel]()
    let tableView = UITableView.init(frame: .zero, style: .plain)
    let presenter = Presenter(service: .init(session: .shared))
    
    //MARK: Data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        if self.dataSource[indexPath.row].image == nil {
            
            self.presenter.getImage(urlByImage: URL(string: self.dataSource[indexPath.row].urls.regular)) { [weak self] (responseImage) in
                self?.dataSource[indexPath.row].image = responseImage
                
            }
        }
        
        cell.configureCell(model: self.dataSource[indexPath.row] )
        
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
    //MARK: Setup
    func setup() -> () {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK: Life cycle's methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
}
