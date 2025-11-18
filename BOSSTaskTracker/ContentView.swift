import SwiftUI

struct ContentView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    private let supportedLanguages: [LanguageOption] = [
        .init(code: "en",    label: "English",           flag: "🇺🇸"),
        .init(code: "fr-CA", label: "Français",          flag: "🇨🇦"),
        .init(code: "zh-HK", label: "中文",               flag: "🇭🇰")
    ]

    private let sampleAmount: Double = 12345.67

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Title + description (Task 1 localized strings)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("app_title")
                            .font(.largeTitle).bold()
                        Text("welcome_title")
                            .font(.title2).bold()
                        Text("welcome_message")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Localized image (Task 2)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("localized_image_section_title")
                            .font(.headline)

                        Image(localizedBackgroundImageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 140)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        Text("localized_image_caption")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }

                    // Locale-specific date, time, number (Task 3)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("locale_section_title")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("today_is").font(.subheadline)
                            Text(formattedToday(for: appLanguage))
                                .font(.body)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("locale_time_label").font(.subheadline)
                            Text(formattedTime(for: appLanguage))
                                .font(.body)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("locale_number_label").font(.subheadline)
                            Text(formattedSampleAmount(for: appLanguage))
                                .font(.body)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Call-to-action (extra localized strings)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("cta_description")
                            .font(.body)
                        Button {
                            // Placeholder action
                        } label: {
                            Text("cta_primary_button")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.borderedProminent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // Quick language picker
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

                    // Navigation to other screens
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
    }

    // MARK: - Locale helpers

    private func formattedToday(for languageIdentifier: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: languageIdentifier)
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }

    private func formattedTime(for languageIdentifier: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: languageIdentifier)
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter.string(from: Date())
    }

    private func formattedSampleAmount(for languageIdentifier: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: languageIdentifier)
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: sampleAmount)) ?? "\(sampleAmount)"
    }

    private var localizedBackgroundImageName: String {
        switch appLanguage {
        case "fr-CA":
            return "background_fr"
        case "zh-HK":
            return "background_zh"
        default:
            return "background_en"
        }
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}
