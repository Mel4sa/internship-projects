//
//  CacheManager.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    private let ratesKey = "cachedRates"
    private let dateKey = "cachedDate"

    func save(rates: [String: Double], date: String) {
        UserDefaults.standard.set(rates, forKey: ratesKey)
        UserDefaults.standard.set(date, forKey: dateKey)
    }

    func loadRates() -> (rates: [String: Double], date: String)? {
        guard let rates = UserDefaults.standard.dictionary(forKey: ratesKey) as? [String: Double],
              let date = UserDefaults.standard.string(forKey: dateKey) else {
            return nil
        }
        return (rates, date)
    }
}
