//
//  ApiManager.swift
//  B WALLET
//
//  Created by YUEMENG TANG on 2023/02/06.
//

import SwiftUI

class CryptoAPI {
    let API_KEY = "A4C94304-578F-4545-972A-B4AE87DF45DA"
    
    func getCryptoData(currency: String,previewMode: Bool, _ completion:@escaping ([Rate]) -> ()) {
        if previewMode {
            completion(Rate.sampleRates)
            return
        }
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)"
        
        guard URL(string: urlString) != nil else {
            print("CryptoAPI: url fails")
            return
        }
        
        var urlComponent = URLComponents(string: urlString)
        
        urlComponent?.queryItems = [URLQueryItem(name: API_KEY, value: "api_key")]
        
        var urlRequest = URLRequest(url:urlComponent!.url!)
        
        urlRequest.setValue(API_KEY, forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                print("CryptoAPI: Could not retrieve data")
                return
            }
            
            do {
                let ratesData = try JSONDecoder().decode(Crypto.self, from: data)
                print("CryptoAPI: SUCCUSS")
                completion(ratesData.rates)
                
            } catch {
                print("CryptoAPI: \(error)")
                completion(Rate.sampleRates)
            }
        }
        .resume()
    }
    
    func getIconData(_ completion:@escaping ([IconUrl]) -> ()) {

        let urlString = "https://rest.coinapi.io/v1/assets/icons/32"
        
        guard URL(string: urlString) != nil else {
            print("CryptoAPI: url fails")
            return
        }
        
        var urlComponent = URLComponents(string: urlString)
        
        urlComponent?.queryItems = [URLQueryItem(name: API_KEY, value: "api_key")]
        
        var urlRequest = URLRequest(url:urlComponent!.url!)
        
        urlRequest.setValue(API_KEY, forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let Data = data else {
            print("CryptoAPI: Could not retrieve data")
            return
            }
                        
            do {
                let iconData = try JSONDecoder().decode([IconUrl].self, from: Data)
                completion(iconData)
            }
            catch{
                print("iconDataerror\(error)")
                completion(IconUrl.sampleIcon)
            }
        }
        .resume()

        
        
    }
}
