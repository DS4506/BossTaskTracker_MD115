import SwiftUI

@main
struct BOSSTaskTrackerApp: App {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Set the locale so all String(localized:) calls and
                // formatters use the selected language and region.
                .environment(\.locale, Locale(identifier: appLanguage))
                // Set layout direction so SwiftUI automatically mirrors
                // stacks, navigation bars, and system controls for RTL languages.
                .environment(\.layoutDirection, isRTLLanguage(appLanguage) ? .rightToLeft : .leftToRight)
        }
    }

    /// Returns true if the language code represents a right-to-left language.
    private func isRTLLanguage(_ code: String) -> Bool {
        let direction = Locale.characterDirection(forLanguage: code)
        return direction == .rightToLeft
    }
}
