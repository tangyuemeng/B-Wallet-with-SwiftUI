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

//MARK Firebase data manager
class Firebase : ObservableObject {
    
    let db = Firestore.firestore()
    
    //MARK function of login
    func login(email : String, password : String) -> Void {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    //MARK function of signup
    func Signup(email : String, password : String) -> Void {
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    //MARK function of saving new balance data to firestore
    func AddData(id : String, password : String, totalbalance : Double) -> Void{
        db.collection("Users").document(id).setData([
            "email": id,
            "password": password,
            "totalbalance": totalbalance
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: ")
            }
        }
    }
    
    //MARK function of getting balance data from firestore
    func GetData(id : String) -> Void{
        db.collection("Users").document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                let email = document.data()!["email"]
                let totalbalance = document.data()!["totalbalance"]
                UserDefaults.standard.set(totalbalance, forKey: UserDefaultsKeys.BalanceInfo().TotalBalance)
                UserDefaults.standard.set(email, forKey: UserDefaultsKeys.AccountInfo().Username)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    //MARK function of updating balance data to firestore
    func Updatedata(id : String, totalbalance : Double) -> Void{
        db.collection("Users").document(id).updateData([
            "totalbalance": totalbalance
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
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
