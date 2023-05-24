//
//  Router.swift
//  ViperPattern
//
//  Created by Zaid Sheikh on 24/05/2023.
//

import Foundation
import UIKit

// object
// Entry point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter{
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
     
        //assign VIP
        
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
