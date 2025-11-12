import SwiftUI

@main
struct BOSSTaskTrackerApp: App {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: appLanguage))
        }
    }
}
