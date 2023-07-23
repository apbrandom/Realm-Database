//
//  NetworkService.swift
//  Realm Database
//
//  Created by Vadim Vinogradov on 20.07.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataLoadingError
    case decodingError
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private let urlString = ChuckNorrisURL.urlString
    
    private init() { }
    
    func fetchRandomQuote(fromURL url: String, complition: @escaping (Result<QuoteResponse, NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            complition(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                complition(.failure(.dataLoadingError))
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                complition(.failure(.dataLoadingError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let quote = try decoder.decode(QuoteResponse.self, from: data)
                complition(.success(quote))
            } catch {
                print("Decoding error : \(error)")
                complition(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
