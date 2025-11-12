import Foundation

// Renamed to avoid conflict with Swift Concurrency TaskGroup<T>
struct BossTaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var done: Bool = false
}

struct BossTaskGroup: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var tasks: [BossTaskItem]
}

extension BossTaskGroup {
    static var sample: [BossTaskGroup] = [
        BossTaskGroup(
            name: NSLocalizedString("demo_group_personal", comment: "Personal group"),
            tasks: [
                BossTaskItem(title: NSLocalizedString("demo_task_buy_groceries", comment: "")),
                BossTaskItem(title: NSLocalizedString("demo_task_call_mom", comment: "")),
                BossTaskItem(title: NSLocalizedString("demo_task_read", comment: ""))
            ]
        ),
        BossTaskGroup(
            name: NSLocalizedString("demo_group_work", comment: "Work group"),
            tasks: [
                BossTaskItem(title: NSLocalizedString("demo_task_review_prs", comment: "")),
                BossTaskItem(title: NSLocalizedString("demo_task_standup", comment: ""))
            ]
        )
    ]
}
