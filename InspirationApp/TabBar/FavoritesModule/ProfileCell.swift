//
//  ProfileCell.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/11/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class ProfileCell: UICollectionViewCell {
    
    private enum Constants {
        static let contentViewCornerRadius: CGFloat = 4.0
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let presenter = FeedPresenter(service: .init(session: .shared))
    override init(frame: CGRect) {
        super.init(frame: .zero)
     
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true//? what for?
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white

        contentView.addSubview(profileImageView)
    }
    
    private func setupLayouts() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(with model: Post){
       // let presenter: FeedPresenter
        
        
        self.presenter.getImage(urlByImage: URL(string: model.imagePostURL!)) {
            [weak self]
            (responseImage)  in
            DispatchQueue.main.async {
                self?.profileImageView.image = responseImage
            }
        }
    }
}

extension ProfileCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
