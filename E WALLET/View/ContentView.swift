//
//  ContentView.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI

struct ContentView: View {
    @State private var emailaddress = ""
    @State private var password = ""
    @State private var wrong_emailaddress = 0
    @State private var wrong_password = 0
    var body: some View {
            VStack(spacing:15) {
                Spacer()
                HStack{
                    Image("icon")
                        .resizable()
                        .frame(width: 150,height: 150)
                        .padding(.bottom,30)
                }
                TextField("Your Email",text:$emailaddress)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.75,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                SecureField("Password",text:$password)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.75,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //LOGIN BUTTON
                NavigationLink(destination:Home())
                {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color("Darkblue"))
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                        .frame(width: UIScreen.main.bounds.width*0.75, height: UIScreen.main.bounds.width*0.13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(
                            Text("Login")
                                .foregroundColor(Color.white)
                                .bold()
                        )
                    
                }
                //SIGN UP BUTTON
                Button(action:{

                })
                {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color("Orange"))
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                        .frame(width: UIScreen.main.bounds.width*0.75, height: UIScreen.main.bounds.width*0.13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(
                            Text("Sign up")
                                .foregroundColor(Color.white)
                                .bold()
                        )
                    
                }
                
            Spacer()

            }.padding(.bottom)
            .navigationBarHidden(true)
     

            //end of vstask
        
    }
       
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
