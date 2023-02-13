//
//  UISetting.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

//MARK view for setting
struct UISetting: View {
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let buildversion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    @State var tag : Int? = 0
    @ObservedObject var viewmodel = ViewModel()
    var body: some View {
        VStack(spacing:10){
            Image("icon")
                .resizable()
                .frame(width: 200,height: 200)
            Text("B WALLET")
                .font(.title)
                .bold()

            HStack(spacing:3){
                Text("Ver")
                    .font(Font.system(size:14))
                    .foregroundColor(Color("Darkblue"))
                    .bold()
                Text(appVersion)
                    .font(Font.system(size:14))
                    .foregroundColor(Color("Darkblue"))
                    .bold()
                Text("("+buildversion+")")
                    .font(Font.system(size:14))
                    .foregroundColor(Color("Darkblue"))
                    .bold()
            }
            
            VStack(spacing:2){
                Text("©️2023 YUEMENG TANG. All Rights Reserved")
                    .font(Font.system(size:11))
                    .foregroundColor(Color("Darkblue"))
                    
                Text(verbatim: "tangyuemeng@toki.waseda.jp")
                    .foregroundColor(Color("Darkblue"))
                    .font(Font.system(size:11))
                    }
            .padding(.bottom)
            
            Spacer()
            Button(action:{
                UserDefaultsKeys().resetUserDefault(username: "", password: "", useronboard: false, totalbalance: 0.0)
                self.tag = 1
            })
            {
                RoundedRectangle(cornerRadius: 13)
                                    .foregroundColor(Color("Darkblue"))
                                    .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(
                                        Text("Sign out")
                                            .foregroundColor(Color.white)
                                            .bold()
                                    )
                                        
            }
            .padding(.bottom)
            .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
            
            NavigationLink(destination: ContentView(), tag: 1, selection: $tag) {
                EmptyView()
            }
        }.frame(width: UIScreen.main.bounds.width)
    }
    
}


struct UISetting_Previews: PreviewProvider {
    static var previews: some View {
        UISetting()
    }
}
