//
//  QuoteResponse.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import Foundation

struct QuoteResponse: Codable {
    let id: String
//    let icon_url: String
//    let url: String
    let value: String
    let category: [String]?
}
