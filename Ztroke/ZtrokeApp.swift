//
//  ZtrokeApp.swift
//  Ztroke
//
//  Created by Zulkifli on 13/04/26.
//

import SwiftUI




@main
struct ZtrokeApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnBoardingScreen()
            } else {
                MainScreen()
            }
        }
    }
}
