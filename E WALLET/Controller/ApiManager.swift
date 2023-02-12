//
//  ApiManager.swift
//  B WALLET
//
//  Created by YUEMENG TANG on 2023/02/06.
//

import Foundation
import SwiftUI
import RxSwift

class CryptoAPI {
    let API_KEY = "A4C94304-578F-4545-972A-B4AE87DF45DA"
    
    func getCryptoDataRx(currency: String) -> Observable<Any> {
        
        return Observable.create { observer in
            
            let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)"
            var urlComponent = URLComponents(string: urlString)
            urlComponent?.queryItems = [URLQueryItem(name: self.API_KEY, value: "api_key")]
            var urlRequest = URLRequest(url:urlComponent!.url!)
            urlRequest.setValue(self.API_KEY, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
                
                guard let Data = data else{
                    print("CryptoAPI: Could not retrieve data")
                    return
                }
                
                do {
                    let ratesData = try JSONDecoder().decode(Crypto.self, from: Data)
                    print("CryptoAPI: SUCCUSS")
                    observer.onNext(ratesData.rates)
                }
                catch let error {
                    print("crypto Dataerror\(error)")
                    observer.onNext(Rate.sampleRates)
                }
                observer.onCompleted()
                }
            task.resume()
            return Disposables.create {
                task.cancel()
            }

        }
    }
    
    func getIconDataRx() -> Observable<Any> {
        
        return Observable.create { observer in
            
            let urlString = "https://rest.coinapi.io/v1/assets/icons/32"
            var urlComponent = URLComponents(string: urlString)
            urlComponent?.queryItems = [URLQueryItem(name: self.API_KEY, value: "api_key")]
            var urlRequest = URLRequest(url:urlComponent!.url!)
            urlRequest.setValue(self.API_KEY, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
                
                guard let Data = data else{
                    return
                }
                
                do {
                    print("icon success")
                    let iconData = try JSONDecoder().decode([IconUrl].self, from: Data)
                    observer.onNext(iconData)
                }
                catch let error {
                    print("iconDataerror\(error)")
                    observer.onError(error)
                }
                observer.onCompleted()
                }
            task.resume()
            return Disposables.create {
                task.cancel()
            }

        }
    }
    
    
    //MARK (Basic)Digital currency icon data from coinAPI
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
    
    //MARK Digital currency rates data from coinAPI
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
}
