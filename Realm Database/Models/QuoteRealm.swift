//
//  Quote.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 19.07.2023.
//

import RealmSwift
import Foundation

class QuoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
//    @Persisted var icon_url: String
//    @Persisted var url: String
    @Persisted var value: String
    @Persisted var category: Category?
    @Persisted var createdAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
