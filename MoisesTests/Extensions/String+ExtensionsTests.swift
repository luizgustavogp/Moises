//
//  String+ExtensionsTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Testing
@testable import Moises

struct StringExtensionsTests {
    
    @Test
    func testOrEmptyReturnsEmptyStringWhenNil() {
        // Arrange
        let sut: String? = nil

        // Act
        let result = sut.orEmpty

        // Assert
        #expect(result == "")
    }

    @Test
    func testOrEmptyReturnsValueWhenNotNil() {
        // Arrange
        let sut: String? = "Moises"

        // Act
        let result = sut.orEmpty

        // Assert
        #expect(result == "Moises")
    }

    @Test
    func testToURLReturnsValidURL() {
        // Arrange
        let sut = "https://moises.ai"

        // Act
        let result = sut.toURL()

        // Assert
        #expect(result?.absoluteString == "https://moises.ai")
    }

    @Test
    func testToURLReturnsNilForInvalidURL() {
        // Arrange
        let sut = "invalid url"

        // Act
        let result = sut.toURL()

        // Assert
        #expect(result == nil)
    }
    
    @Test
    func testToURLReturnsNilForClearlyInvalidURL() {
        // Arrange
        let sut = ""

        // Act
        let result = sut.toURL()

        // Assert
        #expect(result == nil)
    }
}
