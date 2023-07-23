//
//  RealmService.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 21.07.2023.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case savingError
}

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func save<T: Object>(_ object: T, completion: @escaping (Result<Void, RealmError>) -> Void) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
            completion(.success(()))
        } catch {
            completion(.failure(.savingError))
        }
    }
    
    func getQuotes() -> Results<QuoteRealm> {
        return realm.objects(QuoteRealm.self)
    }
    
    func getCategories() -> Results<Category> {
        return realm.objects(Category.self)
    }
}
