//
//  ExchangeRateService.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//

import Foundation

struct ExchangeRatesResponse: Decodable {
    let base: String
    let rates: [String: Double]
    let date: String
}

class ExchangeRateService {
    static let shared = ExchangeRateService()
    
    func fetchRates(base: String = "USD", completion: @escaping (ExchangeRatesResponse?) -> Void) {
        let urlStr = "https://api.exchangerate.host/latest?base=\(base)"
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("API Hatası: \(error?.localizedDescription ?? "Bilinmiyor")")
                completion(nil)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                completion(decoded)
            } catch {
                print("Decode hatası: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
