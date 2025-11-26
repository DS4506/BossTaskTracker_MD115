#if canImport(XCTest)
import XCTest
@testable import BOSSTaskTracker

final class BOSSTaskTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // MARK: - BossTaskItem tests

    func testBossTaskItemDefaultDoneIsFalse() throws {
        let item = BossTaskItem(title: "Test Task")
        XCTAssertEqual(item.title, "Test Task")
        XCTAssertFalse(item.done, "Newly created BossTaskItem should not be marked as done by default.")
    }

    func testBossTaskItemToggleDone() throws {
        var item = BossTaskItem(title: "Toggle Task")
        XCTAssertFalse(item.done)

        item.done.toggle()
        XCTAssertTrue(item.done)

        item.done.toggle()
        XCTAssertFalse(item.done, "Toggling twice should return done to false.")
    }

    // MARK: - BossTaskGroup tests

    func testBossTaskGroupInitialization() throws {
        let tasks = [
            BossTaskItem(title: "One"),
            BossTaskItem(title: "Two")
        ]
        let group = BossTaskGroup(name: "Sample Group", tasks: tasks)

        XCTAssertEqual(group.name, "Sample Group")
        XCTAssertEqual(group.tasks.count, 2)
    }

    func testBossTaskGroupSampleDataNotEmpty() throws {
        let groups = BossTaskGroup.sample
        XCTAssertFalse(groups.isEmpty, "Sample groups should not be empty.")

        let hasTasks = groups.contains { !$0.tasks.isEmpty }
        XCTAssertTrue(hasTasks, "At least one sample group should contain tasks.")
    }

    func testSampleGroupTitlesAreNotEmpty() throws {
        let groups = BossTaskGroup.sample

        for group in groups {
            XCTAssertFalse(group.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                           "Group name should not be empty.")

            for task in group.tasks {
                XCTAssertFalse(task.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                               "Task title should not be empty.")
            }
        }
    }
}

#endif
