import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: BossTaskGroup
    @State private var newTaskTitle: String = ""

    var body: some View {
        VStack(spacing: 12) {
            List {
                Section(header: Text("tasks_header")) {
                    ForEach($group.tasks) { $task in
                        HStack {
                            Button {
                                task.done.toggle()
                            } label: {
                                Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(.plain)

                            Text(task.title)
                                .strikethrough(task.done)
                        }
                    }
                }
            }

            HStack {
                TextField(String(localized: "placeholder_new_task"), text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)

                Button {
                    let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    group.tasks.append(BossTaskItem(title: trimmed))
                    newTaskTitle = ""
                } label: {
                    Text("add_task_button")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .navigationTitle(group.name)
    }
}

#Preview {
    NavigationView {
        TaskGroupDetailView(group: .constant(BossTaskGroup.sample[0]))
    }
}
