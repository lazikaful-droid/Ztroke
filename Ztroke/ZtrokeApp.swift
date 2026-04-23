import SwiftUI

@main
struct ZtrokeApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                SplashScreen()
            } else {
                MainScreen(coordinator: coordinator)
            }
        }
    }
}
