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
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createAuthenticateModule(router: RouterProtocol) -> UIViewController {
        let view = AuthenticateViewController()
        let networkService = NetworkService()

        let presenter = AuthenticatePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createLoginDetailModule(router: RouterProtocol) -> UIViewController {
        let view = LoginDetailViewController()
        //let networkService = NetworkService()
//        let presenter = LoginDeta(view: view, networkService: networkService, router: router)
//        view.presenter = presenter
        return view
        
    }
    
}


