import SwiftUI

struct ContentView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    private let supportedLanguages: [LanguageOption] = [
        .init(code: "en",    label: "English",           flag: "🇺🇸"),
        .init(code: "fr-CA", label: "Français",          flag: "🇨🇦"),
        .init(code: "zh-HK", label: "中文",               flag: "🇭🇰")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("app_title")
                            .font(.largeTitle).bold()
                        Text("welcome_title")
                            .font(.title2).bold()
                        Text("welcome_message")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("today_is").font(.headline)
                        Text(formattedToday(for: appLanguage))
                            .font(.title3)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button {} label: {
                        Text("get_started")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("language_switcher_title")
                            .font(.headline)

                        Picker("language_picker_accessibility_label", selection: $appLanguage) {
                            ForEach(supportedLanguages) { lang in
                                Text("\(lang.flag) \(lang.label)")
                                    .tag(lang.code)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(spacing: 12) {
                        NavigationLink(destination: ManageGroupsView()) {
                            HStack(spacing: 8) {
                                Image(systemName: "list.bullet.rectangle")
                                Text("nav_manage_groups")
                                Spacer()
                            }
                            .padding()
                            .background(.quaternary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        NavigationLink(destination: ProfileView()) {
                            HStack(spacing: 8) {
                                Image(systemName: "person")
                                Text("nav_profile")
                                Spacer()
                            }
                            .padding()
                            .background(.quaternary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle(Text("app_title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LanguageSettingsView()) {
                        Image(systemName: "gearshape")
                    }
                    .accessibilityLabel(Text("settings_title"))
                }
            }
        }
        .environment(\.locale, Locale(identifier: appLanguage))
    }

    private func formattedToday(for languageIdentifier: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: languageIdentifier)
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}
