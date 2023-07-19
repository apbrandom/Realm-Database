//
//  Quote.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 19.07.2023.
//

import RealmSwift
import Foundation

class Quote: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var icon_url: String
    @Persisted var url: String
    @Persisted var value: String
//    @Persisted var category: Category?
    @Persisted var careatedAt: Data = Data()
    
    override static func primaryKey() -> String? {
            return "id"
        }
}
