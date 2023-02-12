//
//  ContentView.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct ContentView: View {
    @State private var emailaddress = ""
    @State private var password = ""
    @State private var tag : Int? = 0
    @State private var showdialog = false
    @State var errormessage = ""
    var body: some View {
        ZStack{
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
                
                Button(action:{
                    self.ResetPassword(email: emailaddress)
                }){
                    HStack{
                        Text("Forget password? Click here!")
                            .font(.caption)
                            .foregroundColor(Color("Darkblue"))
                        Spacer()
                    }}
                .frame(width: UIScreen.main.bounds.width*0.75)
                
                //LOGIN BUTTON
                Button(action:{
                    self.login(email: emailaddress, password: password)
                })
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
                    self.Signup(email: emailaddress, password: password)
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
                
                NavigationLink(destination: Home(), tag: 1, selection: $tag) {
                    EmptyView()
                }
            }.padding(.bottom)
              
            //end of vstask
            
            if showdialog {
                Dialog(errormessage: $errormessage)
            }
        }
        .navigationBarHidden(true)
            
        
    }
    
    func login(email : String, password : String) -> Void {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                showdialog.toggle()
                errormessage = error?.localizedDescription ?? "Unknow Error"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    showdialog.toggle()
                })
                print(error?.localizedDescription ?? "")
            } else {
                showdialog.toggle()
                errormessage = "Loading..."
                Firebase().GetData(id: email)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    showdialog.toggle()
                    self.tag = 1
                })
            }
        }
    }
    
    func Signup(email : String, password : String) -> Void {
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if error != nil {
                showdialog.toggle()
                errormessage = error?.localizedDescription ?? "Unknow Error"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    showdialog.toggle()
                })
                print(error?.localizedDescription ?? "")
            } else {
                showdialog.toggle()
                errormessage = "Loading..."
                Firebase().AddData(id: email, password: password, totalbalance: 0.0)
                UserDefaultsKeys().resetUserDefault(username: emailaddress, password: password, useronboard: true, totalbalance: 0.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    showdialog.toggle()
                    self.tag = 1
                })
            }
        }
    }
    
    func ResetPassword(email : String) -> Void {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                showdialog.toggle()
                errormessage = error?.localizedDescription ?? "Unknow Error"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    showdialog.toggle()
                })
                print(error?.localizedDescription ?? "")
            }
            else {
                
            }
        }
    }
    
       
    }


struct Dialog : View {
    @Binding var errormessage : String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
                .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                .frame(width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.width*0.5, alignment: .center)
                .overlay(
                    VStack(spacing:10){
//                       Image(systemName:"person.crop.circle.badge.exclamationmark")
//                            .resizable()
                        ActivityIndicator()
                            .foregroundColor(Color("Darkblue"))
                            .frame(width: 40,height: 40)
                            .padding(.top,30)
                        Text(errormessage)
                            .bold()
                            .padding()
                        Spacer()
                    }
                )
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
