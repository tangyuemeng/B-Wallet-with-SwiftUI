import SwiftUI
import Foundation


class ViewModel: ObservableObject {
    @Published var rates = [Rate]()
    @Published var iconurls = [IconUrl]()
    @Published var searchText = ""
    @Published var iconid = ""
    
    init(rates: [Rate] = [Rate](), iconurls: [IconUrl] = [IconUrl](), searchText: String = "", iconid : String = "") {
        print("datamanager:data")
        self.fetchData()
        print("datamanager:icon")
        self.fetchicon()
    }
    
    var filterRates: [Rate] {
        return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
    }
    
    func filterIcon(searchText : String) -> String{
        let iconurl = iconurls.filter { $0.asset_id == searchText.uppercased() }
        return iconurl.isEmpty ? "" : iconurl[0].url
    }
    
    func calcRate(rate: Rate) -> Double {
        return  rate.rate
    }
    
    func fetchData() {
        CryptoAPI().getCryptoData(currency: "USD", previewMode: false) {newRates in
            DispatchQueue.main.async {
                withAnimation {
                    self.rates = newRates
                }
            }
        }
    }
    
    func fetchicon(){
        CryptoAPI().getIconData() {icondata in
            DispatchQueue.main.async {
                withAnimation {
                    self.iconurls = icondata
                }
            }
        }
    }
    
}

