import SwiftUI

struct LanguageSettingsView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    private let languages: [LanguageOption] = [
        .init(code: "en",    label: "English",           flag: "🇺🇸"),
        .init(code: "fr-CA", label: "Français (Canada)", flag: "🇨🇦"),
        .init(code: "zh-HK", label: "中文（香港）",         flag: "🇭🇰")
    ]

    var body: some View {
        Form {
            Section(header: Text("settings_language_section_title")) {
                ForEach(languages) { lang in
                    Button {
                        appLanguage = lang.code
                    } label: {
                        HStack {
                            Text(lang.flag)
                            Text(lang.label)
                            Spacer()
                            if appLanguage == lang.code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                    .foregroundColor(.primary)
                }
            }

            Section(
                header: Text("settings_reset_section_title"),
                footer: Text("settings_reset_description")
            ) {
                Button(role: .destructive) {
                    appLanguage = "en"
                } label: {
                    Text("settings_reset_button")
                }
            }
        }
        .navigationTitle(Text("settings_title"))
    }
}

#Preview {
    NavigationView {
        LanguageSettingsView()
            .environment(\.locale, Locale(identifier: "en"))
    }
}
