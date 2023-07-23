//
//  QuoteResponse.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import Foundation

struct QuoteResponse: Codable {
    let categories: [String]?
    let created_at: String?
    let icon_url: URL?
    let id: String
    let updated_at: String?
    let url: URL
    let value: String
}

