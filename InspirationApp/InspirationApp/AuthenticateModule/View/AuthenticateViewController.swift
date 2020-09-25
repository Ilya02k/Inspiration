//
//  ViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/22/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class AuthenticateViewController: UIViewController {

    
    var presenter: AuthenticateViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setUpController()
    }
    
    func setUpController() {
        let loginButton = UIButton(type: UIButton.ButtonType.system)
        
        
        loginButton.setTitle("Log In", for: UIControl.State.normal)
        loginButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        
        loginButton.layer.cornerRadius = 30
        loginButton.backgroundColor = UIColor.white
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/16),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])

        
        loginButton.addTarget(self, action: #selector(authenticate), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func authenticate(){
        presenter.tapOnTheLoginButton()
    }


    
}

extension AuthenticateViewController: AuthenticateViewProtocol {
    func success() {
        //tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

