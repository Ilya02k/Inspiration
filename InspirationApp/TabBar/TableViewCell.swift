//
//  TableViewCell.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/2/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    public var saveBlock:  (() -> ())?
    
    private var heightConstraint: NSLayoutConstraint? {
        didSet {
            if let oldValue = oldValue {
                photoImageView.removeConstraint(oldValue)
            }
            if let aspectConstraint = heightConstraint {
                aspectConstraint.priority = .init(rawValue: 999)
                aspectConstraint.isActive = true
            }
        }
    }
    
    
    func configureCell(model: AdvancedPhotoModel) -> (){
        post = model
        authorLabel.text = model.user.name
        photoImageView.image = (model.image != nil) ? model.image : UIImage(named: "placeholder")
     

        
        var ratio = 1.0
        if let image = model.image {
            ratio = Double(image.size.height/image.size.width)
        }

        heightConstraint = photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: CGFloat(ratio))

    }
    var post: AdvancedPhotoModel? {
        didSet {
            authorLabel.text = post?.user.name
            photoImageView.image = post?.image
            photoImageView.sizeToFit()
        }
    }
    
     let authorLabel: UILabel = {
        let lbl = UILabel()
        //lbl.textColor = .black
       // lbl.font = UIFont.boldSystemFont(ofSize: 16)
       // lbl.textAlignment = .left
        
        return lbl
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "favorites"), for: UIControl.State.normal)
        return button
    }()
    lazy var photoImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(self.authorLabel)
        verticalStackView.addArrangedSubview(self.photoImageView)
        verticalStackView.addArrangedSubview(self.favoriteButton)

        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])

        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        authorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        favoriteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        self.addSubview(authorLabel)
//        self.addSubview(photoImageView)
//
//
//
//        authorLabel.translatesAutoresizingMaskIntoConstraints = false
//        photoImageView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 0 )
//        widthConstraint = photoImageView.widthAnchor.constraint(equalToConstant: 0)
//
//
//        NSLayoutConstraint.activate([
////            authorLabel.heightAnchor.constraint(equalToConstant: 40),
////            authorLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
//            heightConstraint, widthConstraint,
//
//            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            authorLabel.topAnchor.constraint(equalTo: self.topAnchor),
//
//            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            photoImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//
//
//    }
    @objc func configureSaveButton () -> () {
        favoriteButton.addTarget(self, action: #selector(saveToCoreData), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func saveToCoreData () -> () {
        if (self.saveBlock != nil) {
            self.saveBlock!()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
