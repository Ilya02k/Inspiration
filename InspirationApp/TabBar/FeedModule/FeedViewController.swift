//
//  FeedViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, FeedPresenterDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cell"
    let presenter = FeedPresenter(service: .init(session: .shared))
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

        let oneItem = presenter.dataSource[indexPath.row]

      //  DispatchQueue.main.async {
            cell.configureCell(model: self.presenter.dataSource[indexPath.row] )
       // }

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


        if self.presenter.dataSource[indexPath.row].image == nil {
            // DispatchQueue.global(qos: .background).async {

            self.presenter.getImage(urlByImage: URL(string: self.presenter.dataSource[indexPath.row].urls.regular)) { (responseImage) in
                DispatchQueue.main.async { [weak self] in
                    self?.presenter.dataSource[indexPath.row].image = responseImage
                    
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
            }
        }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
//        cell.directionalLayoutMargins = .zero
//        cell.layoutMargins = .zero
//        cell.contentView.directionalLayoutMargins = .zero
//        cell.contentView.layoutMargins = .zero
//        if cell.photoImageView.image == nil {
//            let item = presenter.dataSource[indexPath.row]
//            cell.authorLabel.text = item.user.name
//            let ratio: CGFloat = CGFloat(item.height / item.width)
//            DispatchQueue.global(qos: .background).async {
//                if let data = try? Data(contentsOf: URL(string: self.presenter.dataSource[indexPath.row].urls.regular)!) {
//                    let width = UIScreen.main.bounds.width
//                    DispatchQueue.main.async {
//
//                        cell.photoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
//                        cell.photoImageView.heightAnchor.constraint(equalToConstant: width*ratio).isActive = true
//                        cell.photoImageView.image = UIImage(data: data)
//
//                        tableView.reloadRows(at: [indexPath], with: .fade)
//                    }
//                }
//            }
//
//        }
//        cell.post = self.presenter.dataSource[indexPath.row]
//        cell.configureSaveButton()
//        cell.saveBlock = { [weak self]
//            in
//            var item = cell.post
//            if item?.isFavorite == true {
//                item = self?.presenter.removeFromCoreData(item: &cell.post!)
//            }
//            else {
//                item = self?.presenter.saveToCoreData(item: &cell.post!)
//            }
//        }
//        return cell
//    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
//        if cell.photoImageView.image == nil {
//            let item = presenter.dataSource[indexPath.row]
//
//
//        }
//
//
//        return cell
//    }
    
    
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
//            let oneItem = presenter.dataSource[indexPath.row]
//            let height = oneItem.height
//            let width = oneItem.width
//            let ratio = height/width
//            let currentHeight = UIScreen.main.bounds.size.width * CGFloat(ratio)
//
//           // cell.post = self.presenter.dataSource[indexPath.row]
//
//            DispatchQueue.main.async {
//                NSLayoutConstraint.activate([
//                cell.photoImageView.heightAnchor.constraint(equalToConstant: currentHeight ),
//                    cell.photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
//                ])
//                //cell.photoImageView.image = self.presenter.dataSource[indexPath.row].image
//                cell.post = self.presenter.dataSource[indexPath.row]
//
//                tableView.reloadRows(at: [indexPath], with: .fade)
//            }
//           // cell.post = self.presenter.dataSource[indexPath.row]
//
//            cell.configureSaveButton()
//            cell.saveBlock = { [weak self]
//                in
//                var item = cell.post
//                if item?.isFavorite == true {
//                    item = self?.presenter.removeFromCoreData(item: &cell.post!)
//                }
//                else {
//                    item = self?.presenter.saveToCoreData(item: &cell.post!)
//                }
//            }
//            return cell
//        }
        

    


    
    //MARK:  life cycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        view.addSubview(self.tableView)
       // tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        

    }
    

    
    func showError(error: Error) {
        print(error)
    }

}
