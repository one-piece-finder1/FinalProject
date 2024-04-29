//
//  Quote.swift
//  Quote Getter - Final Project
//
//  Created by Sri Nandan Gondi on 22/04/24.
//

import Foundation



//struct QuoteResponse: Decodable {
//    let results: [Quote]
//}

struct Quote: Codable, Equatable {
    let _id: String
    let author: String
    let content: String
}

extension Quote{
    
    static var savedQuotesKey: String {
        return "Saved Quotes"
    }
    
    static func save(_ quotes: [Quote], forKey key: String) {
        
        let defaults = UserDefaults.standard
        
        let encodedData = try! JSONEncoder().encode(quotes)
        
        defaults.set(encodedData, forKey: key)
    }
    
    static func getQuotes(forKey key: String) -> [Quote] {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        if let data = defaults.data(forKey: key) {
            // 3.
            let decodedQuotes = try! JSONDecoder().decode([Quote].self, from: data)
            // 4.
            return decodedQuotes
        } else {
            // 5.
            return []
        }
    }
    
}
