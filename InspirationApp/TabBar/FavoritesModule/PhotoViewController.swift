//
//  PhotoViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/19/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit


class PhotoViewController: UIViewController  {

    var photoImageView: UIImageView
    let favoriteButton: UIButton
    lazy var stackView: UIStackView = {
    let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    func setup() -> (){
        favoriteButton.setImage(UIImage.init(named: "favorites"), for: UIControl.State.normal)
        self.view.addSubview(stackView)
     //   self.view.addSubview(photoImageView)
       // photoImageView.addSubview(favoriteButton)
        
       // self.photoImageView.clipsToBounds = true
        self.photoImageView.contentMode = .scaleAspectFit
        
        
        self.stackView.addArrangedSubview(self.photoImageView)
        self.stackView.addArrangedSubview(self.favoriteButton)
        //self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
       // self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
//        NSLayoutConstraint.activate([
//            self.photoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            self.photoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//
//            self.favoriteButton.widthAnchor.constraint(equalToConstant: 50),
//            self.favoriteButton.heightAnchor.constraint(equalToConstant: 50),
//
//
//            self.favoriteButton.bottomAnchor.constraint(equalTo: self.photoImageView.image.),
//            self.favoriteButton.trailingAnchor.constraint(equalTo: self.photoImageView.image.trailingAnchor)
//        ])
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
   
   init(cell: ProfileCell) {
    self.photoImageView = cell.profileImageView
    self.favoriteButton = UIButton()
    super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
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
