//
//  AssemblyModelBuilder.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createAuthenticateModule(router: RouterProtocol) -> UIViewController
    func createLoginDetailModule(router: RouterProtocol) -> UIViewController
    func createTabBarModule(router: RouterProtocol) -> UITabBarController
    func createTableViewController(router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createAuthenticateModule(router: RouterProtocol) -> UIViewController {
        let view = AuthenticateViewController()

        let presenter = AuthenticatePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createLoginDetailModule(router: RouterProtocol) -> UIViewController {
        let view = LoginDetailViewController()
        return view
    }
    
    func createTabBarModule(router: RouterProtocol) ->UITabBarController {
        let view = GeneralTabBarController()
        return view
    }
    func createTableViewController(router: RouterProtocol) -> UIViewController {
        let view = FeedViewController()
        return view
    }
    
}


