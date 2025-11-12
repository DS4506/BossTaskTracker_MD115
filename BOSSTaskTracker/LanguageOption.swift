import Foundation

struct LanguageOption: Identifiable, Hashable {
    let id = UUID()
    let code: String
    let label: String
    let flag: String
}
