//
//  Router.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get  set }
}

protocol RouterProtocol: RouterMain {
    func initialAuthenticateController()
    func showLoginDetail() -> ()
    func popToRoot()
    func initialTabBarController()
    var keyChain: KeychainSwift { get }
}

class Router: RouterProtocol {
    
    
    var navigationController: UINavigationController?
    var keyChain: KeychainSwift
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?, keyChain: KeychainSwift){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.keyChain = keyChain
    }
    
    
    func initialAuthenticateController() {
        if let navigationController = navigationController {
            guard let authenticateViewController = assemblyBuilder?.createAuthenticateModule(router: self) else { return }
            navigationController.viewControllers = [authenticateViewController]
            navigationController.navigationBar.isHidden = true
        }
    }
    func initialTabBarController() {
        if let navigationController = navigationController {
            guard let tabBarController = assemblyBuilder?.createTabBarModule(router: self) else { return }
            navigationController.pushViewController(tabBarController, animated: false)
            navigationController.navigationBar.isHidden = true
        }
    }
    
    func showLoginDetail () -> () {
        if let navigationController = navigationController {
            
            if let builder = assemblyBuilder {
                let loginDetailViewController = builder.createLoginDetailModule(router: self) {
                    DispatchQueue.main.async {
                        navigationController.dismiss(animated: true, completion: nil)
                        self.initialTabBarController()
                    }
                    
                }
                navigationController.present(loginDetailViewController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func popToRoot() {
        // smth
    }
    
    
    
    
}
