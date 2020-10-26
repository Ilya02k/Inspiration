//
//  Router.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit


protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get  set }
}

protocol RouterProtocol: RouterMain {
    func initialAuthenticateController()
    func showLoginDetail()
    func popToRoot()
    func initialTabBarController()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
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
    
    func showLoginDetail() {
        if let navigationController = navigationController {
            guard let loginDetailViewController = assemblyBuilder?.createLoginDetailModule(router: self) else { return }
            navigationController.present(loginDetailViewController, animated: true, completion: nil)
        }
    }
    
    
    func popToRoot() {
        // smth
    }
    
    
    
    
}
