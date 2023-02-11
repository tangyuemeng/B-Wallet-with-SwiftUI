//
//  E_WALLETApp.swift
//  E WALLET
//
//  Created by YUEMENG TANG on 2023/02/04.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
// ...
      
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct E_WALLETApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //MARK here to check if user first lauch 
    let useronboarded = UserDefaults.standard.bool(forKey:UserDefaultsKeys.AccountInfo().UserOnBoarded)
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if useronboarded {
                    Home()
                }
                else{
                    ContentView()
                }
            }
        }
    }
}
