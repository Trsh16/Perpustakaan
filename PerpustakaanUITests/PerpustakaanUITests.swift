//
//  PerpustakaanUITests.swift
//  PerpustakaanUITests
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import XCTest

final class PerpustakaanUITests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testAddMemberForm() throws {
        let app = XCUIApplication()
        app.launch()

        let launchScreenAttachment = XCTAttachment(screenshot: app.screenshot())
        launchScreenAttachment.name = "Launch Screen"
        launchScreenAttachment.lifetime = .keepAlways
        add(launchScreenAttachment)

        let addNewMemberButton = app.buttons["Add New Member"]
        XCTAssertTrue(addNewMemberButton.exists, "The 'Add New Member' button should exist")
        addNewMemberButton.tap()

        let addMemberTitle = app.staticTexts["Add Member"]
        XCTAssertTrue(addMemberTitle.exists, "The AddMemberView screen should be displayed after tapping 'Add New Member'")

        let nameTextField = app.textFields["Member Name"]
        XCTAssertTrue(nameTextField.exists, "The 'Member Name' text field should exist")
        nameTextField.tap()
        nameTextField.typeText("Trisha")

        let addressTextField = app.textFields["Member Address"]
        XCTAssertTrue(addressTextField.exists, "The 'Member Address' text field should exist")
        addressTextField.tap()
        addressTextField.typeText("Jln. Dharmahusada")

        let addMemberButton = app.buttons["Add Member"]
        XCTAssertTrue(addMemberButton.exists, "The 'Add Member' button should exist")
        addMemberButton.tap()

        let successAlert = app.alerts["Member Added"]
        XCTAssertTrue(successAlert.exists, "The success alert should appear after adding a member")

        successAlert.buttons["OK"].tap()

        let addMemberFormScreenshot = XCTAttachment(screenshot: app.screenshot())
        addMemberFormScreenshot.name = "Add Member Form After Success"
        addMemberFormScreenshot.lifetime = .keepAlways
        add(addMemberFormScreenshot)
    }
}
