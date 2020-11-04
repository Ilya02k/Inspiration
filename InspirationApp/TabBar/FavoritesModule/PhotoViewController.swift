//
//  PhotoViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/19/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit


class PhotoViewController: UIViewController  {
    //MARK: Properties
    private var photoImageView:  UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "favorites"), for: UIControl.State.normal)
        return button
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    //MARK: Setup
    func setup() -> () {
        view.addSubview(photoImageView)
        
        photoImageView.addSubview(favoriteButton)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            photoImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    //MARK: initializer
    init(cell: ProfileCell) {
        photoImageView.image = cell.profileImageView.image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}
