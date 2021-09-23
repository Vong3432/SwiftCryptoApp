//
//  SwiftCryptoAppApp.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 17/09/2021.
//

import SwiftUI

@main
struct SwiftCryptoAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
