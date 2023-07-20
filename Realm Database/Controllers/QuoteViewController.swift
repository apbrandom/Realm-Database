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
    
    private var lastFetchedQuote: QuoteResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func downloadQuoteButtonTapped(_ sender: Any) {
        NetworkService.shared.fetchRandomQuote { [weak self] result in
            
            switch result {
            case .success(let quoteResponse):
                DispatchQueue.main.async {
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
        quote.careatedAt = Date()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(quote)
            }
            print("Quote saved successfully!")
        } catch {
            //add ALERT
            print("Failed to write to database: \(error.localizedDescription)")
        }
    }
}
