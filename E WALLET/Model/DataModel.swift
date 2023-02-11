//
//  DataModel.swift
//  B WALLET
//
//  Created by YUEMENG TANG on 2023/02/06.
//

import SwiftUI

//MARK data model of b wallet
//MARK Digital currency data model with defalut data
struct Crypto: Decodable {
    let asset_id_base: String
    let rates: [Rate]
}

struct Rate: Decodable,Identifiable{
    let id = UUID()
    let time: String
    let asset_id_quote: String
    let rate: Double
    
    static var sampleRates: [Rate] {
        var tempRates = [Rate]()
        
        for i in 0...9 {
            let randomNumber = Double(Array(0...1000).randomElement()!)
            let Currency = ["BUSD","TRX","USDC","SOL","ADA","XRP","BNB","USDT","ETH","BTC"]
            let sampleRate = Rate(time: "2023-2-23", asset_id_quote: Currency[i], rate: randomNumber)
            tempRates.insert(sampleRate, at: 0)
        }
        return tempRates
    }
    
}
//MARK Digital currency icon model with defalut data
struct IconUrl: Decodable{
    let asset_id: String
    let url:String
    
    static var sampleIcon: [IconUrl] {
        var sampleicon = [IconUrl]()
        
        for i in 0...9 {
            let randomNumber = Double(Array(0...1000).randomElement()!)
            let Currency = ["BUSD","TRX","USDC","SOL","ADA","XRP","BNB","USDT","ETH","BTC"]
            let Url = [
                       "https://s2.coinmarketcap.com/static/img/coins/64x64/4687.png",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Ftron%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fusd-coin%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fsolana%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fcardano%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fxrp%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fbnb%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Ftether%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fethereum%2Fcolor_icon.png&w=48&q=75",
                       "https://crypto.com/price/_next/image?url=https%3A%2F%2Fstatic.crypto.com%2Ftoken%2Ficons%2Fbitcoin%2Fcolor_icon.png&w=48&q=75"]
            let sample = IconUrl(asset_id: Currency[i], url: Url[i])
            sampleicon.insert(sample, at: 0)
        }
        return sampleicon
    }
}

//MARK UserDefaults key data
struct UserDefaultsKeys {

    struct AccountInfo {
        let Username = "Username"
        let Password = "Password"
        let UserOnBoarded = "UserOnBoarded"
    }
    
    struct BalanceInfo {
        let TotalBalance = "TotalBalance"
    }

    func resetUserDefault (username:String,password:String,useronboard:Bool,totalbalance:Double){
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: UserDefaultsKeys.AccountInfo().Username)
        defaults.set(password, forKey: UserDefaultsKeys.AccountInfo().Password)
        defaults.set(useronboard, forKey: UserDefaultsKeys.AccountInfo().UserOnBoarded)
        defaults.set(totalbalance, forKey: UserDefaultsKeys.BalanceInfo().TotalBalance)
        
    }
}
