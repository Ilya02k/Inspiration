//
//  AssemblyModelBuilder.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift
protocol AssemblyBuilderProtocol {
    func createAuthenticateModule(router: RouterProtocol) -> UIViewController
    func createLoginDetailModule(router: RouterProtocol, completion: @escaping ()->()) -> (UIViewController)
    func createTabBarModule(router: RouterProtocol) -> UITabBarController
    func createTableViewController(router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
  //  let
    
    func createAuthenticateModule(router: RouterProtocol) -> UIViewController {
        let view = AuthenticateViewController()

        let presenter = AuthenticatePresenter(view: view, router: router, service: NetworkService.init(session: .shared))
        view.presenter = presenter
        return view
    }
    
    func createLoginDetailModule(router: RouterProtocol, completion: @escaping ()->()) -> (UIViewController) {
        let view = LoginDetailViewController(completion: completion)
        let presenter = AuthenticatePresenter(view: view, router: router, service: NetworkService.init(session: .shared))
        view.presenter = presenter
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


