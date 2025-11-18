import Foundation

struct LanguageOption: Identifiable, Hashable {
    let id = UUID()
    let code: String      // e.g. "en", "fr-CA", "zh-HK"
    let label: String     // Display name
    let flag: String      // Emoji flag
}
