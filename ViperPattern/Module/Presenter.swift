//
//  Presenter.swift
//  ViperPattern
//
//  Created by Zaid Sheikh on 24/05/2023.
//

import Foundation

// object
// protocol
// ref interactor, router, view

enum FetchError: Error{
    case failed
}

protocol AnyPresenter{
    var router: AnyRouter? { get set}
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set}
    
    func interactorDidFetchUser(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter{
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUser(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "something went wrong")
        }
    }
}
