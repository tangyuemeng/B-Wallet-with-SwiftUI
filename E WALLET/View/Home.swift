//
//  Home.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

//MARK main menu
// Three screens(UIStart,UIWallet,UISetting)selected by pageNumber
// top and bottom navi are fixed
struct Home: View {
    @State var pageNumber = 1
    @State var offset: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
    var body: some View {
            VStack(spacing:0){
                top_banner()
                HStack(spacing:0){
                    UIStart()
                    UIWallet()
                    UISetting()
                }
                .offset(x: CGFloat((pageNumber-1))*offset.width, y: 0)
                .animation(.interpolatingSpring(stiffness: 100, damping: 100))
                Spacer()
                bottom_navi(pageNumber: $pageNumber)

            }.navigationBarHidden(true)
    }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK view for top banner
struct top_banner: View {
    @State var Userid : String = UserDefaults.standard.string(forKey: UserDefaultsKeys.AccountInfo().Username) ?? ""
    var body: some View {
        VStack{
            HStack(spacing:10){
                Image("userpage")
                    .resizable()
                    .frame(width: 35,height: 35)
                VStack(alignment:.leading){
                    HStack{
                        Text("hello!")
                            .font(.subheadline)
                        Text(Userid)
                            .font(.subheadline)
                    }
                    Text("Welcome back")
                        .font(.subheadline)
                        .bold()
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width-20)
    }
}

//MARK view for bottom_navi
struct bottom_navi: View {
    @Binding var pageNumber : Int
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 2)
                                .foregroundColor(Color("Darkblue"))
                                .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                                .frame(width:(UIScreen.main.bounds.width-90)/4,height:4)
                                .offset(x:CGFloat (1-self.pageNumber)*(UIScreen.main.bounds.width+40)/3)
                                .animation(.interpolatingSpring(stiffness: 100, damping: 100))
            HStack(){
                VStack{
                    Image(pageNumber == 2 ? "home_selected":"home")
                        .resizable()
                        .frame(width: pageNumber == 2 ? 32:28,height:pageNumber == 2 ? 32:28)
                    Text("home")
                        .font(.caption)
                        .foregroundColor(pageNumber == 2 ? Color("Darkblue"):Color.black)              }
                .frame(width: (UIScreen.main.bounds.width-90)/3)
                .onTapGesture{
                    pageNumber = 2
                }
                Spacer()
                VStack{
                    Image(pageNumber == 1 ? "wallet_selected":"wallet")
                        .resizable()
                        .frame(width: pageNumber == 1 ? 32:28,height:pageNumber == 1 ? 32:28)
                    Text("wallet")
                        .font(.caption)
                        .foregroundColor(pageNumber == 1 ? Color("Darkblue"):Color.black)
                }
                .frame(width: (UIScreen.main.bounds.width-90)/3)
                .onTapGesture{
                    pageNumber = 1
                    }
                Spacer()
                VStack{
                    Image(pageNumber == 0 ? "setting_selected":"setting")
                        .resizable()
                        .frame(width: pageNumber == 0 ? 32:28,height:pageNumber == 0 ? 32:28)
                    Text("setting")
                        .font(.caption)
                        .foregroundColor(pageNumber == 0 ? Color("Darkblue"):Color.black)
                }
                .frame(width: (UIScreen.main.bounds.width-90)/3)
                .onTapGesture{
                    pageNumber = 0
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
