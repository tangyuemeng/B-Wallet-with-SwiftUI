import SwiftUI
import Foundation
import RxSwift
//MARK viewmodel for swiftui
class ViewModel: ObservableObject {
    @Published var rates = [Rate]()
    @Published var iconurls = [IconUrl]()
    @Published var searchText = ""
    @Published var iconid = ""
    private let disposeBag = DisposeBag()
    
    init(rates: [Rate] = [Rate](), iconurls: [IconUrl] = [IconUrl](), searchText: String = "", iconid : String = "") {
        self.fetchData()
        self.fetchicon()
    }
    //MARK get filtered rate data
    var filterRates: [Rate] {
        return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
    }
    
    //MARK get filtered icon data
    func filterIcon(searchText : String) -> String{
        let iconurl = iconurls.filter { $0.asset_id == searchText.uppercased() }
        return iconurl.isEmpty ? "" : iconurl[0].url
    }
    
    func calcRate(rate: Rate) -> Double {
        return  rate.rate
    }
    
    func fetchData() {
        CryptoAPI().getCryptoDataRx(currency: "USD").subscribe({response in
            switch response {
                case let .next(data):
                DispatchQueue.main.async{
                    withAnimation {
                        self.rates = data as! [Rate]
                    }
                }
                case let .error(error):
                    print(error)
                case .completed:
                    break
            }
        }).disposed(by: disposeBag)
//        CryptoAPI().getCryptoData(currency: "USD", previewMode: false) {newRates in
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.rates = newRates
//                }
//            }
//        }

    }
    
    
    func fetchicon(){
        CryptoAPI().getIconDataRx().subscribe({response in
            switch response {
                case let .next(data):
                DispatchQueue.main.async{
                    withAnimation {
                        self.iconurls = data as! [IconUrl]
                    }
                }
                case let .error(error):
                    print(error)
                case .completed:
                    break
            }
        }).disposed(by: disposeBag)
        
    }
    
}

