//
//  AuhtenticatePresenter.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol AuthenticateViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol AuthenticateViewPresenterProtocol: class {
    init(view: AuthenticateViewProtocol, router: RouterProtocol)
    func tapOnTheLoginButton()
}

class AuthenticatePresenter: AuthenticateViewPresenterProtocol {

    weak var view: AuthenticateViewProtocol?
    var router: RouterProtocol?
    
    required init(view: AuthenticateViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func tapOnTheLoginButton() {
        router?.showLoginDetail()
    }
    
    
}
