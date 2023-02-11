//
//  Firebase.swift
//  B WALLET
//
//  Created by YUEMENG TANG on 2023/02/10.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class Firebase : ObservableObject {
    func login(email : String, password : String) -> Void {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func Signup(email : String, password : String) -> Void {
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
//    func SignupLink() -> Void {
//        Auth.auth().currentUser?.sendEmailVerification { error in
//            // ...
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            } else {
//                print("success")
//            }
//        }
//    }
}
