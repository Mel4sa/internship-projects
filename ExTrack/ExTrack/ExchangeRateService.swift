//
//  ExchangeRateService.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//API işlemleri için kullanılacak ExchangeRateService.swift dosyası

import Foundation

// API'den gelen yanıt yapısı
struct ExchangeRatesResponse: Decodable {
    let rates: [String: Double]
    let date: String
}

// Servis sınıfı
class ExchangeRateService {
    static let shared = ExchangeRateService()
    
    private let apiKey = "b939d820d8753dc55b11cb8bb9ae355d"
    
    func fetchRates(completion: @escaping (ExchangeRatesResponse?) -> Void) {
        let urlStr = "https://api.exchangerate.host/latest?base=EUR&access_key=\(apiKey)"
        
        guard let url = URL(string: urlStr) else {
            print("Geçersiz URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("API hatası: \(error?.localizedDescription ?? "bilinmiyor")")
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                completion(decoded)
            } catch {
                print("Decode hatası: \(error)")
                if let json = try? JSONSerialization.jsonObject(with: data) {
                    print("Gelen veri:\n\(json)")
                }
                completion(nil)
            }
        }
        task.resume()
    }
}
