import SwiftUI

struct ManageGroupsView: View {
    @State private var groups: [BossTaskGroup] = BossTaskGroup.sample

    var body: some View {
        List {
            Section(header: Text("groups_header")) {
                ForEach($groups) { $group in
                    NavigationLink(destination: TaskGroupDetailView(group: $group)) {
                        HStack {
                            Text(group.name)
                            Spacer()
                            Text("\(group.tasks.count)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(Text("manage_groups_title"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let new = BossTaskGroup(
                        name: String(localized: "new_group_default_name"),
                        tasks: []
                    )
                    groups.append(new)
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel(Text("a11y_add_group"))
            }
        }
    }
}

#Preview {
    NavigationView { ManageGroupsView() }
}
