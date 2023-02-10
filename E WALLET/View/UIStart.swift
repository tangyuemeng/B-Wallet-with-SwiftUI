//
//  UIStart.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

struct UIStart: View {
    @ObservedObject var viewmodel = ViewModel()
    @State var iconurls = [IconUrl]()
//    init(){
//        viewmodel.fetchicon()
//    }
    var body: some View {
        VStack{
            HStack{
                Text("Today rates")
                    .opacity(0.5)
                .bold()
                .padding(.leading)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width)
            
            HStack{
                Text("$USD")
                    .font(.largeTitle)
                .bold()
                .padding(.leading)
                Spacer()
            }
            .padding(.bottom)
            .frame(width: UIScreen.main.bounds.width)
            
            List(viewmodel.filterRates) {item in
                HStack {
                    AsyncImage(
                        url: URL(string: viewmodel.filterIcon(searchText: item.asset_id_quote)),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: 30, maxHeight: 30)
                        },
                        placeholder: {
                            //
                        }
                    )
//                    AsyncImage(url: URL(string: viewmodel.filterIcon(searchText: item.asset_id_quote)))
//                        .frame(width: 28,height: 28)
                    Text(item.asset_id_quote)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(viewmodel.calcRate(rate: item), specifier: "%.2f")")
                }
                .listRowSeparator(.hidden)
                .listRowBackground(LinearGradient(colors: [Color("Orange").opacity(0.9), Color("Darkblue").opacity(0.9)],startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            .background(Color.clear)
            .listStyle(.plain)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
            .frame(width: UIScreen.main.bounds.width*0.94, height: UIScreen.main.bounds.height*0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    
            Spacer()
        }.padding(.top)
    }
}

struct UIStart_Previews: PreviewProvider {
    static var previews: some View {
        UIStart()
    }
}
