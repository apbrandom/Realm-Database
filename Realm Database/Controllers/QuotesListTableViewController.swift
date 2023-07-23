//
//  QuotesListTableViewController.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import UIKit
import RealmSwift

class QuotesListTableViewController: UITableViewController {
    
    var quotes: Results<QuoteRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadQuotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func LoadQuotes() {
        do {
            let realm = try Realm()
            quotes = realm.objects(QuoteRealm.self).sorted(byKeyPath: "createdAt", ascending: false)
            tableView.reloadData()
        } catch {
            print("Failed to fetch quotes: \(error.localizedDescription)")
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
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            let dateString = formatter.string(from: quote.createdAt)
            
            configuration.text = quote.value
            configuration.secondaryText = dateString
        }
        
        cell.contentConfiguration = configuration
        return cell
    }
}
