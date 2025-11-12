import SwiftUI

struct ProfileView: View {
    var body: some View {
        Form {
            Section(header: Text("profile_header")) {
                LabeledContent {
                    Text("profile_value_username_example")
                } label: {
                    Text("profile_label_username")
                }

                LabeledContent {
                    Text("profile_value_role_example")
                } label: {
                    Text("profile_label_role")
                }
            }

            Section {
                Text("profile_footer_note")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(Text("profile_title"))
    }
}

#Preview {
    NavigationView { ProfileView() }
}
