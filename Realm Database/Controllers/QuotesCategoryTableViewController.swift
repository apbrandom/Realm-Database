//
//  QuotesCategoryTableViewController.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 23.07.2023.
//

import UIKit
import RealmSwift

class QuotesCategoryTableViewController: UITableViewController {
    
    var category: Category?
    var quotes: Results<QuoteRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuotes()
        tableView.reloadData()
    }
    
    func loadQuotes() {
        guard let category = category else { return }
        
        do {
            let realm = try Realm()
            quotes = realm.objects(QuoteRealm.self).filter("category.name == %@", category.name)
            
        } catch {
            print("Failed to fetch jokes: \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        
        if let quote = quotes?[indexPath.row] {
            configuration.text = quote.value
        }
        cell.contentConfiguration = configuration
        return cell
    }
}
