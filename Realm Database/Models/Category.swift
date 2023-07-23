//
//  Category.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 19.07.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var name: String
    var quotes: LinkingObjects<QuoteRealm> {
            return LinkingObjects(fromType: QuoteRealm.self, property: "category")
        }
}

