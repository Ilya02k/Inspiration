//
//  SearchResultViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/18/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellId = "cell"
    var dataSource = [AdvancedPhotoModel]()
    let tableView = UITableView.init(frame: .zero, style: .plain)
    let presenter = FeedPresenter(service: .init(session: .shared))
    
    //MARK: data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        let oneItem = self.dataSource[indexPath.row]
        let height = oneItem.height
        let width = oneItem.width
        let ratio = height/width
        let currentHeight = UIScreen.main.bounds.size.width * CGFloat(ratio)
        
        NSLayoutConstraint.activate([
            cell.photoImageView.heightAnchor.constraint(equalToConstant: currentHeight ),
            cell.photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
            
        ])
        
        cell.post = self.dataSource[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if self.dataSource[indexPath.row].image == nil {
            // DispatchQueue.global(qos: .background).async {
            
            self.presenter.getImage(urlByImage: URL(string: self.dataSource[indexPath.row].urls.regular)) { (responseImage) in
                DispatchQueue.main.async {
                    if let cell: TableViewCell  = tableView.cellForRow(at: indexPath) as? TableViewCell {
                        cell.post?.image = responseImage
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
