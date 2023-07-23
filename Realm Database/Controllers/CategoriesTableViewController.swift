//
//  CategoriesTableViewController.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import UIKit
import RealmSwift

class CategoriesTableViewController: UITableViewController {
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        printAllCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        do {
            let realm = try Realm()
            categories = realm.objects(Category.self)
            tableView.reloadData()
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
        }
    }
    
    func printAllCategories() {
        
        do {
            let realm = try Realm()
            let categories = realm.objects(Category.self)

            for category in categories {
                print("Category Name: \(category.name)")
            }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var congiguration = UIListContentConfiguration.cell()
        
        if let category = categories?[indexPath.row] {
            congiguration.text = category.name
        }
    
        cell.contentConfiguration = congiguration
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = categories?[indexPath.row]
        performSegue(withIdentifier: "showCurrnetCategory", sender: category )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showCurrnetCategory",
               let destinationVC = segue.destination as? QuotesCategoryTableViewController,
               let category = sender as? Category {
                destinationVC.category = category
            }
        }
}
