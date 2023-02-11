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
    
    let db = Firestore.firestore()
    
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
    
    func AddData() -> Void{
        var ref: DocumentReference? = nil
        ref = db.collection("Users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
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
