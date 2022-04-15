//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationView{
            HomeView()
              .navigationBarHidden(true)
              .environmentObject(HomeViewModel())
          }
        }
    }
}
