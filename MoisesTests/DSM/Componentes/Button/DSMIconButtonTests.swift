//
//  DSMIconButtonTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 16/06/25.
//

import Testing
import ViewInspector
import SwiftUI
@testable import Moises

@Suite
@MainActor
struct DSMIconButtonTests {
    
    @Test
    func testRendersTitle() throws {
        // Arrange
        let sut = DSMIconButton(icon: .system(name: "gear"), title: "Settings", action: {})

        // Act
        let title = try sut.inspect().find(DSMTitle.self).anyView().text().string()

        // Assert
        #expect(title == "Settings")
    }

    @Test
    func testRendersIcon() throws {
        // Arrange
        let sut = DSMIconButton(icon: .system(name: "gear"), title: "Settings", action: {})

        // Assert
        #expect(try sut.inspect().find(DSMImage.self) != nil)
    }

    @Test
    func testTapExecutesAction() throws {
        // Arrange
        var tapped = false
        let sut = DSMIconButton(icon: .system(name: "gear"), title: "Tap me", action: { tapped = true })

        // Act
        let button = try sut.inspect().find(ViewType.Button.self)
        try button.tap()

        // Assert
        #expect(tapped)
    }
}
