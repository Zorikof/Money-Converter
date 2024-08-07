import SwiftUI

@main
struct Money_ConverterApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true

    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                WelcomeView(isFirstLaunch: $isFirstLaunch)
            } else {
                MainView()
            }
        }
    }
}

