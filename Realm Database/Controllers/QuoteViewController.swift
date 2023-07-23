//
//  QuoteViewController.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import UIKit
import RealmSwift

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    var url = ChuckNorrisURL.urlString
    var categories = CategoryList.list
    var selectedCategory = "default"
    private var lastFetchedQuote: QuoteResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
    }
    
    @IBAction func downloadQuoteButtonTapped(_ sender: Any) {
        var url = ChuckNorrisURL.urlString
        
        if selectedCategory != "default" {
            url = "\(url)?category=\(selectedCategory)"
        }
        
        NetworkService.shared.fetchRandomQuote(fromURL: url) { [weak self] result in
            
            switch result {
            case .success(let quoteResponse):
                DispatchQueue.main.async {
                    print("Fetched categories: \(String(describing: quoteResponse.categories?.description))")
                    self?.quoteLabel.text = quoteResponse.value
                    self?.lastFetchedQuote = quoteResponse
                }
            case .failure(let error):
                print("Failed to fetch quote: \(error.localizedDescription)")
                
            }
        }
    }
    
    @IBAction func saveToRealmButtonTapped(_ sender: Any) {
        guard let quoteResponse = lastFetchedQuote else {
            print("No quote to save")
            return
        }
        
        let quote = QuoteRealm()
        quote.id = quoteResponse.id
        quote.value = quoteResponse.value
        quote.createdAt = Date()
        
        if let categoryNames = quoteResponse.categories, !categoryNames.isEmpty {
            let categoryName = categoryNames[0]
            
            do {
                let realm = try Realm()
                if let category = realm.object(ofType: Category.self, forPrimaryKey: categoryName) {
                    // Existing category found, use it.
                    quote.category = category
                } else {
                    // No existing category found, create a new one.
                    let category = Category()
                    category.name = categoryName
                    quote.category = category
                }
            } catch let error {
                print("Failed to save quote: \(error)")
                return
            }
        }
        
        RealmService.shared.save(quote) { result in
            switch result {
            case .success:
                print("Quote saved successfully!")
            case .failure(let error):
                print("Failed to save quote: \(error)")
            }
        }
    }
}


