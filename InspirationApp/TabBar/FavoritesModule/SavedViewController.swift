//
//  SavedViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit
import CoreData

class SavedViewController: UIViewController {

    var dataSource = [AdvancedPhotoModel]()
    
    var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //MARK: Fetch Result Controller
    lazy var fetchedResultsController: NSFetchedResultsController =  { () -> NSFetchedResultsController<Post> in
        
        let fetchRequest: NSFetchRequest = Post.fetchRequest()
        let frcTemp = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frcTemp.delegate = self as? NSFetchedResultsControllerDelegate //pay attention later, Ilya! I dont like this cast. smth strange in my opinion
        return frcTemp
    }()
        

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    


    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContext.automaticallyMergesChangesFromParent = true
        setupViews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try self.fetchedResultsController.performFetch()
            self.collectionView.reloadData()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
   //MARK: setup
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
    }
    
    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    //MARK: LayoutConstant
    private enum LayoutConstant {
        static let spacing: CGFloat = 5.0
        static let itemHeight: CGFloat = 200.0
    }
    



}
//MARK: Data Source Methods
extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        let photo = self.fetchedResultsController.fetchedObjects?[indexPath.row]
        
        
        cell.setup(with: photo!)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}
//MARK: Delegate Methods
extension SavedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: ProfileCell = collectionView.cellForItem(at: indexPath) as! ProfileCell
        let photoViewController = PhotoViewController.init(cell: cell)
        self.present(photoViewController, animated: true, completion: nil)
    }
}
//MARK: DelegateFlowLayout
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: 0)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        return UIScreen.main.bounds.size.width/itemsInRow - LayoutConstant.spacing-3
    }
}
