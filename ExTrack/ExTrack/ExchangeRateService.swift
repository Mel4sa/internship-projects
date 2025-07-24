//
//  ExchangeRateService.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//API işlemleri için kullanılacak ExchangeRateService.swift dosyası

import Foundation

struct ExchangeRatesResponse: Decodable {
    let rates: [String: Double]
    let base: String
    let date: String
}

class ExchangeRateService {
    static let shared = ExchangeRateService()
    private let apiKey = "b939d820d8753dc55b11cb8bb9ae355d"

    func fetchRates(base: String = "EUR", completion: @escaping (ExchangeRatesResponse?) -> Void) {
        let urlString = "https://api.exchangerate.host/latest?base=\(base)&access_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Geçersiz URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Veri alınamadı: \(error?.localizedDescription ?? "Bilinmeyen hata")")
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
