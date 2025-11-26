#if canImport(XCTest)
import XCTest

final class BOSSTaskUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testAppLaunchesAndShowsMainTitle() throws {
        let app = XCUIApplication()
        app.launch()

        // English title for app_title
        let navBar = app.navigationBars["BossTaskTracker"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5),
                      "The main navigation bar with title BossTaskTracker should appear on launch.")
    }

    func testCanOpenLanguageSettingsScreen() throws {
        let app = XCUIApplication()
        app.launch()

        // Gear button with accessibility label from settings_title
        let settingsButton = app.buttons["Settings"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 5),
                      "Settings button should exist in the navigation bar.")
        settingsButton.tap()

        let settingsNavBar = app.navigationBars["Settings"]
        XCTAssertTrue(settingsNavBar.waitForExistence(timeout: 5),
                      "Settings navigation bar should appear after tapping the Settings button.")

        let languageLabel = app.staticTexts["Language"]
        XCTAssertTrue(languageLabel.waitForExistence(timeout: 5),
                      "Language section title should exist on the Settings screen.")
    }

    func testLanguageSegmentedControlExists() throws {
        let app = XCUIApplication()
        app.launch()

        let settingsButton = app.buttons["Settings"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 5))
        settingsButton.tap()

        let englishOption = app.buttons.containing(
            NSPredicate(format: "label CONTAINS %@", "English")
        ).firstMatch

        let frenchOption = app.buttons.containing(
            NSPredicate(format: "label CONTAINS %@", "Français")
        ).firstMatch

        XCTAssertTrue(englishOption.exists || frenchOption.exists,
                      "At least one language option such as English or Français should exist.")
    }

    func testResetToEnglishButtonExists() throws {
        let app = XCUIApplication()
        app.launch()

        let settingsButton = app.buttons["Settings"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 5))
        settingsButton.tap()

        let resetButton = app.buttons["Reset to English"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 5),
                      "Reset to English button should exist on the Settings screen.")
    }
}

#endif
