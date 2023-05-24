//
//  Interactor.swift
//  ViperPattern
//
//  Created by Zaid Sheikh on 24/05/2023.


import Foundation
import UIKit
// object
// protocol
// ref to presenter

//api

protocol AnyInteractor{
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor{
    
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUser(with: .failure(FetchError.failed))
                return
            }
            do{
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUser(with: .success(entities))
            }
            catch{
                self?.presenter?.interactorDidFetchUser(with: .failure(error))
            }
        }
        task.resume()
    }

}
