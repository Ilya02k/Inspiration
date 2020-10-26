//
//  FeedPresenter.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/1/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit
import CoreData
protocol FeedPresenterDelegate: class {
    func showError(error: Error)
//    func updateData()
}

class FeedPresenter {
    
    weak var delegate: FeedPresenterDelegate?
    
    let service: NetworkService
    let imageLoader = ImageLoader()
    var dataSource: Array<AdvancedPhotoModel>
    
    init(service: NetworkService){
        self.service = service
        self.dataSource = []
    }
    func getData(completion: @escaping () -> () ){
        self.service.fetch(.getPhotos) { (result: Result<[AdvancedPhotoModel], Error>) in
            switch result {
            case .success(let array):
                //self.dataSource.removeAll()
               // DispatchQueue.global(qos: .background).async {
                    self.dataSource.append(contentsOf: array)
                    completion()
              //  }
                
            case .failure(let error):
                self.delegate?.showError(error: error)
                
            }
        }
    }
    
    func getImage(urlByImage: URL?, completion: @escaping (UIImage) -> () ) {
        
        if let urlByDataWhichNeeded = urlByImage {
            imageLoader.loadWithUrl(url: urlByDataWhichNeeded) { (responseImage) in
                DispatchQueue.main.async {
                    completion(responseImage!)
                }
                
            }
        }
    }
    
    func saveToCoreData(item: inout AdvancedPhotoModel ) -> (AdvancedPhotoModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.newBackgroundContext()
        item.isFavorite = !item.isFavorite
        context.performAndWait {
            let dataItem: Post = Post.init(context: context)
            dataItem.imagePostURL = item.urls.regular
        }
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
            print(error.localizedDescription)
        }
        
        return item
    }
    func removeFromCoreData(item: inout AdvancedPhotoModel) -> (AdvancedPhotoModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.newBackgroundContext()
        item.isFavorite = !item.isFavorite
        let request = NSFetchRequest<NSManagedObject>(entityName: "Post")
        context.performAndWait {
            do {
                if let result = try? context.fetch(request).last {
                    context.delete(result) //?
                    
                }
            }
            catch {
                
                print(error.localizedDescription)
            }
        }
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
            print(error.localizedDescription)
        }
        return item
    }
    
    func getSearchData(query: String?, completion: @escaping () -> () ){
        if let queryForSearch = query {
            self.service.fetch(.getSearchResults(searchText: queryForSearch)) { (result: Result<SearchResults, Error>) in
                switch result {
                case .success(let responseObject):
                    self.dataSource.removeAll()
                    DispatchQueue.global(qos: .background).async {
                        self.dataSource.append(contentsOf: responseObject.results)
                        completion()
                    }
                case .failure(let error):
                    self.delegate?.showError(error: error)
                }
            }
        }
    }
}
