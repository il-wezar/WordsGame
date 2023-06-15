//
//  WordsGameApp.swift
//  WordsGame
//
//  Created by Illia Wezarino on 11.06.2023.
//

import SwiftUI
import Firebase

let screen = UIScreen.main.bounds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct WordsGameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            StartView(viewModel: StartViewModel(word: WordModel(word: "")))
        }
    }
}
