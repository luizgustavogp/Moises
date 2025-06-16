//
//  View+ExtensionsTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import SwiftUI
import ViewInspector
import Testing
@testable import Moises

@MainActor
struct ViewIsHiddenTests {
    
    @Test
    func testIsHiddenTrueKeepsViewButHidesIt() throws {
        // Arrange
        let sut = Text("Hidden View").isHidden(true, remove: false)
        
        // Act
        let isHidden = try sut.inspect().anyView().text().isHidden()
        
        // Assert
        #expect(isHidden == true)
    }
    
    @Test
    func testIsHiddenFalseKeepsViewVisible() throws {
        // Arrange
        let sut = Text("Visible View").isHidden(false)
        
        // Act
        let isHidden = try sut.inspect().anyView().text().isHidden()
        
        // Assert
        #expect(isHidden == false)
    }
    
    @Test
    func testIsHiddenTrueWithRemoveRemovesView() {
        // Arrange
        let sut = Text("Removed View").isHidden(true, remove: true)
        
        // Act
        let text = try? sut.inspect().anyView().text()
        
        // Assert
        #expect(text == nil)
    }
}
