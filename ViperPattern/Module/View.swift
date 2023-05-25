//
//  View.swift
//  ViperPattern
//
//  Created by Zaid Sheikh on 24/05/2023.
//

import Foundation
import UIKit
// view controller
// protocol
// reference presenter


protocol AnyView{
    var presenter: AnyPresenter? { get set}
    
    func update(with user: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
    
    var presenter: AnyPresenter?
    
    var users: [User] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with user: [User]) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.users = user
            self.tableView.reloadData()
        }
        
    }
    
    func update(with error: String) {
        print(error)
    }
    
    //MARK: - table view delegate func
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    
}
