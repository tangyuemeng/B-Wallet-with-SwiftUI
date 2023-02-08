//
//  UIWallet.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

struct UIWallet: View {
    @State var totalbalance = "1,334,550"
    var body: some View {
        VStack{
            HStack{
                Text("Total balance")
                .bold()
                .opacity(0.3)
                .padding(.leading)
                Spacer()
            }
            HStack{
                Text("$"+totalbalance)
                .bold()
                .font(.largeTitle)
                .padding(.leading)
                Spacer()
            }
            
            Button(action:{}){
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
                                .foregroundColor(Color.black)
                                .font(.title)
                                .bold()
                        }
                    )
            }
            
            Button(action:{}){
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
                        }
                    )
            }
            
            Spacer()
        }.frame(width: UIScreen.main.bounds.width)
        .padding(.top)
    }
}

struct UIWallet_Previews: PreviewProvider {
    static var previews: some View {
        UIWallet()
    }
}
