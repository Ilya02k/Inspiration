//
//  FeedPresenter.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/1/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol FeedPresenterDelegate: class {
    func showError(error: Error)
//    func updateData()
}

class FeedPresenter {
    
    weak var delegate: FeedPresenterDelegate?
    
    let service: NetworkService
    var dataSource: Array<PhotoModel>
    init(service: NetworkService){
        self.service = service
        self.dataSource = []
    }
    func getData(completion: @escaping () -> () ){
        self.service.fetch(.getPhotos) { (result: Result<[PhotoModel], Error>) in
            switch result {
            case .success(let array):
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: array)
                completion()
                
            case .failure(let error):
                self.delegate?.showError(error: error)
                
            }
            
            
        }
    }
}
