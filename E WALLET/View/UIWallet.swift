//
//  UIWallet.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

//MARK view for wallet
struct UIWallet: View {
    @State var totalbalance = UserDefaults.standard.double(forKey: UserDefaultsKeys.BalanceInfo().TotalBalance)
    @State var shoesheet = false
    @State var sheettitle = ""
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Total balance")
                        .bold()
                        .opacity(0.3)
                        .padding(.leading)
                    Spacer()
                }
                HStack{
                    Text("$"+String(totalbalance))
                        .bold()
                        .font(.largeTitle)
                        .padding(.leading)
                    Spacer()
                }
                
                Button(action:{
                    withAnimation{
                        self.sheettitle = "Send"
                        self.shoesheet = true}
                }){
                    RoundedRectangle(cornerRadius: 13)
                        .fill(LinearGradient(colors: [Color("Orange").opacity(0.9), Color("Darkblue").opacity(0.9)],startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.width*0.5, alignment: .center)
                        .padding(.bottom)
                        .overlay(
                            HStack(spacing:10){
                                Image("pay")
                                    .resizable()
                                    .frame(width:140,height: 140)
                                Text("Send")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                                    .bold()
                                    .offset(x:35,y:55)
                            }
                        )
                }
                
                Button(action:{
                    withAnimation{
                        self.sheettitle = "Receive"
                        self.shoesheet = true}
                }){
                    RoundedRectangle(cornerRadius: 13)
                        .fill(LinearGradient(colors: [Color("Darkblue").opacity(0.99), Color("Orange").opacity(0.99)],startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.width*0.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(
                            HStack(spacing:15){
                                Image("receive")
                                    .resizable()
                                    .frame(width:140,height: 140)
                                Text("Receive")
                                    .foregroundColor(Color.black)
                                    .font(.title)
                                    .bold()
                                    .offset(x:21,y:60)
                            }
                        )
                }
                
                Spacer()
            }.frame(width: UIScreen.main.bounds.width)
                .padding(.top)
        //zstask here
            if shoesheet {
                BottomSheetView(title: sheettitle, showsheet: $shoesheet, totalbalance: $totalbalance).ignoresSafeArea()
            }
        
        }
    }
}

//MARK view for sheet
struct BottomSheetView : View {
    @ObservedObject var viewmodel = ViewModel()
    @State var offsetY : CGFloat = UIScreen.main.bounds.height
    @State var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.AccountInfo().Username)
    @State var title : String
    @State var searchId = ""
    @State var searchRate = 0.0
    @State var amount = 0.0
    @Binding var showsheet : Bool
    @Binding var totalbalance : Double
    var body: some View {
        ZStack{
//            Color.black.opacity(0.5)
            
            VStack{
                RoundedRectangle (cornerRadius: 3, style: .continuous)
                    .frame (width: 40, height: 5)
                    .padding (8)
                    .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                  
                
                HStack(spacing: 16) {
                    Text (title) .font(.largeTitle).bold ()
                    Button {
                        withAnimation{
                            if title == "Send"{
                                totalbalance -= amount*searchRate}
                            if title == "Receive" {
                                totalbalance += amount*searchRate
                            }
                            Firebase().Updatedata(id: email!, totalbalance: totalbalance)
                            UserDefaults.standard.set(totalbalance,forKey: UserDefaultsKeys.BalanceInfo().TotalBalance)
                            self.showsheet.toggle()
                            
                        }
                        
                    } label: {Label("Add", systemImage: "plus.circle.fill")
                            .font(.body.bold () )
                            .foregroundColor (.white)
                            .padding (8)
                            .padding (.horizontal, 8)
                    }
                    .background (Color("Orange"))
                    .cornerRadius (30)
                    .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                    Spacer()
                }
                .padding(24)
                
                TextField("Search as BTC ",text:$viewmodel.searchText)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.9,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                List(viewmodel.filterRates) {item in
                    HStack {
                        Text(item.asset_id_quote)
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(viewmodel.calcRate(rate: item), specifier: "%.2f")")
                    }
                    .onTapGesture {
                        withAnimation{
                            searchId = item.asset_id_quote
                            searchRate = (viewmodel.calcRate(rate: item))
                            viewmodel.searchText = ""
                        }
                    }
                }
                .opacity(viewmodel.searchText == "" ? 0 : 1)
                .background(Color.clear)
                .listStyle(.plain)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    VStack{
                        HStack {
                            Text(searchId)
                                .fontWeight(.bold)
                            Spacer()
                            Text("$"+String(searchRate))
                                .fontWeight(.bold)
                        }
                        .opacity(viewmodel.searchText == "" ? 1 : 0)
                        .frame(width: UIScreen.main.bounds.width*0.82, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        Spacer()
                    }
                )
                

                
                //slide bar
                VStack {
                    Stepper("Amount: \(Int(amount))", value: $amount, step: 10)
                    
                    Slider(value: $amount, in: 1...10_000)
                }
                .padding()
               
                Button(action:{
                    withAnimation{
                        self.showsheet.toggle()}
                })
                {
                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundColor(Color("Darkblue"))
                                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .overlay(
                                            Text("Cancel")
                                                .foregroundColor(Color.white)
                                                .bold()
                                        )
                                            
                }
                .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                .padding(.bottom)
                Spacer()
                
            }
            .ignoresSafeArea(edges: .top)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 50,style: .continuous))
            .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
            .offset(y:showsheet ? withAnimation{ offsetY*0.2 } : offsetY)
        }
    }
}

struct UIWallet_Previews: PreviewProvider {
    static var previews: some View {
        UIWallet()
    }
}

