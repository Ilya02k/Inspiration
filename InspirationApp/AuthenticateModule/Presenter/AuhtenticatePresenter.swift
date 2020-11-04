//
//  AuhtenticatePresenter.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import KeychainSwift
protocol AuthenticateViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol AuthenticateViewPresenterProtocol: class {
    //init(view: AuthenticateViewProtocol, router: RouterProtocol)
    init(view: AuthenticateViewProtocol, router: RouterProtocol, service: NetworkService)
    func tapOnTheLoginButton()
   // var keyChain: KeychainSwift { get }
    func getToken(code: String? , completion: @escaping () -> ())
    
}

protocol AuthenticatePresenterDelegate: class {
    func showError(error: Error)
}

class AuthenticatePresenter: AuthenticateViewPresenterProtocol {

    let service: NetworkService
    weak var delegate: AuthenticatePresenterDelegate?
    lazy var code = ""
    weak var view: AuthenticateViewProtocol?
    var router: RouterProtocol?
    
    func getToken(code: String? , completion: @escaping () -> ()) {
        guard let codeForAccess = code else { return }
        service.fetch(.getToken(code: codeForAccess)) { [weak self] (result: Result<AccessToken?, Error>)
            in
            switch result {
            case .success(let token):
                if let accessToken = token{
                    self?.router?.keyChain.set(accessToken.accessToken, forKey: "accessToken")
                  completion()
                  print("Token is gotten")
                }
            case .failure(let error):
                print(error)
                self?.delegate?.showError(error: error)
            }
            
        }
    }
    

    
    required init(view: AuthenticateViewProtocol, router: RouterProtocol, service: NetworkService) {
        self.view = view
        self.router = router
        self.service = service
    }
    
    
    func tapOnTheLoginButton() {
        router?.showLoginDetail()
    }
    
    
}
