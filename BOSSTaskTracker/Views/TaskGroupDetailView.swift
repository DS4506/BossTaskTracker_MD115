import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: BossTaskGroup
    @State private var newTaskTitle: String = ""
    @Environment(\.layoutDirection) private var layoutDirection

    private var isRTL: Bool {
        layoutDirection == .rightToLeft
    }

    var body: some View {
        VStack(spacing: 12) {
            List {
                Section(header: Text("tasks_header")) {
                    ForEach($group.tasks) { $task in
                        HStack {
                            if isRTL {
                                Text(task.title)
                                    .strikethrough(task.done)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                toggleButton(for: $task)
                            } else {
                                toggleButton(for: $task)
                                Text(task.title)
                                    .strikethrough(task.done)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }

            HStack {
                if isRTL {
                    addTaskButton
                    TextField(String(localized: "placeholder_new_task"), text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.trailing)
                } else {
                    TextField(String(localized: "placeholder_new_task"), text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    addTaskButton
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .navigationTitle(group.name)
    }

    private func toggleButton(for task: Binding<BossTaskItem>) -> some View {
        Button {
            task.wrappedValue.done.toggle()
        } label: {
            Image(systemName: task.wrappedValue.done ? "checkmark.circle.fill" : "circle")
        }
        .buttonStyle(.plain)
    }

    private var addTaskButton: some View {
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
}

#Preview {
    NavigationView {
        TaskGroupDetailView(group: .constant(BossTaskGroup.sample[0]))
    }
}
