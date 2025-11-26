import SwiftUI

struct ContentView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "en"

    /// All languages the app explicitly supports.
    /// Arabic is included here to demonstrate RTL support.
    private let supportedLanguages: [LanguageOption] = [
        .init(code: "en",    label: "English",           flag: "🇺🇸"),
        .init(code: "fr-CA", label: "Français",          flag: "🇨🇦"),
        .init(code: "zh-HK", label: "中文",               flag: "🇭🇰"),
        .init(code: "ar",    label: "العربية",           flag: "🇸🇦")
    ]

    private let sampleAmount: Double = 12345.67

    /// Convenience flag used throughout the view to adapt alignment and layout.
    private var isRTL: Bool {
        Locale.characterDirection(forLanguage: appLanguage) == .rightToLeft
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: isRTL ? .trailing : .leading, spacing: 20) {
                    headerSection
                    localizedImageSection
                    localeFormattingSection
                    ctaSection
                    culturalCustomizationSection
                    languagePickerSection
                    navigationSection
                }
                .padding(20)
                // Make the whole scroll view respect trailing alignment for RTL.
                .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
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

    // MARK: - Sections

    /// Top title and description. Uses localized strings and switches alignment for RTL.
    private var headerSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 6) {
            Text("app_title")
                .font(.largeTitle)
                .bold()

            Text("welcome_title")
                .font(.title2)
                .bold()

            Text("welcome_message")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(isRTL ? .trailing : .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    /// Shows a background image that changes per locale, including an Arabic-specific theme.
    private var localizedImageSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 8) {
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
                .multilineTextAlignment(isRTL ? .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
    }

    /// Demonstrates locale-aware date, time and number formatting.
    private var localeFormattingSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 12) {
            Text("locale_section_title")
                .font(.headline)

            VStack(alignment: isRTL ? .trailing : .leading, spacing: 4) {
                Text("today_is")
                    .font(.subheadline)
                Text(formattedToday(for: appLanguage))
                    .font(.body)
            }

            VStack(alignment: isRTL ? .trailing : .leading, spacing: 4) {
                Text("locale_time_label")
                    .font(.subheadline)
                Text(formattedTime(for: appLanguage))
                    .font(.body)
            }

            VStack(alignment: isRTL ? .trailing : .leading, spacing: 4) {
                Text("locale_number_label")
                    .font(.subheadline)
                Text(formattedSampleAmount(for: appLanguage))
                    .font(.body)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    /// Localized call-to-action. The visual emphasis color subtly changes per culture.
    private var ctaSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 8) {
            Text("cta_description")
                .font(.body)
                .multilineTextAlignment(isRTL ? .trailing : .leading)

            Button {
                // Placeholder action
            } label: {
                Text("cta_primary_button")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(localeAccentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
    }

    /// Explicitly shows how OK and Cancel ordering and icon placement can change for RTL.
    private var culturalCustomizationSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 8) {
            Text("cultural_section_title")
                .font(.headline)

            Text("cultural_section_body")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(isRTL ? .trailing : .leading)

            CulturallyAwareConfirmationBar(isRTL: isRTL)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    /// Quick language switcher that writes into @AppStorage so the whole app updates.
    private var languagePickerSection: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 8) {
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
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
    }

    /// Navigation to the task-management and profile screens.
    private var navigationSection: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: ManageGroupsView()) {
                HStack(spacing: 8) {
                    // Icon automatically flips in RTL because we have set layoutDirection.
                    Image(systemName: "list.bullet.rectangle")
                    Text("nav_manage_groups")
                    Spacer(minLength: 0)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
                .background(Color(.quaternarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            NavigationLink(destination: ProfileView()) {
                HStack(spacing: 8) {
                    Image(systemName: "person")
                    Text("nav_profile")
                    Spacer(minLength: 0)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
                .background(Color(.quaternarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
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

    /// Returns a locale-specific background image name.
    /// The asset catalog contains matching images for each case.
    private var localizedBackgroundImageName: String {
        switch appLanguage {
        case "fr-CA":
            return "background_fr"
        case "zh-HK":
            return "background_zh"
        case "ar":
            return "background_ar"
        default:
            return "background_en"
        }
    }

    /// A very simple theme example: change the accent color based on the locale.
    private var localeAccentColor: Color {
        switch appLanguage {
        case "fr-CA":
            // Calm blue for French Canadian
            return .blue
        case "zh-HK":
            // Red is common in many East-Asian interfaces
            return .red
        case "ar":
            // Green is frequently used in Arabic-language experiences
            return .green
        default:
            return .accentColor
        }
    }
}

/// A small reusable bar that swaps the order of primary and secondary buttons
/// depending on whether the interface is LTR or RTL. This satisfies the
/// requirement to reverse OK and Cancel for right-to-left cultures.
struct CulturallyAwareConfirmationBar: View {
    let isRTL: Bool

    var body: some View {
        HStack {
            if isRTL {
                primaryButton
                Spacer()
                secondaryButton
            } else {
                secondaryButton
                Spacer()
                primaryButton
            }
        }
        .padding(.vertical, 4)
    }

    private var primaryButton: some View {
        Button {
            // Confirm action placeholder
        } label: {
            Label("ok_button_label", systemImage: isRTL ? "checkmark.circle" : "checkmark.circle.fill")
                .frame(minWidth: 80)
        }
        .buttonStyle(.borderedProminent)
    }

    private var secondaryButton: some View {
        Button {
            // Cancel action placeholder
        } label: {
            Label("cancel_button_label", systemImage: isRTL ? "xmark.circle.fill" : "xmark.circle")
                .frame(minWidth: 80)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}
