//
//  Int+ExtensionsTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Testing
@testable import Moises

struct IntExtensionsTests {
    
    @Test
    func testOrZeroWithNil() {
        // Arrange
        let value: Int? = nil
        
        // Act
        let sut = value.orZero
        
        // Assert
        #expect(sut == 0)
    }
    
    @Test
    func testOrZeroWithValue() {
        // Arrange
        let value: Int? = 42
        
        // Act
        let sut = value.orZero
        
        // Assert
        #expect(sut == 42)
    }
    
    @Test
    func testAsDouble() {
        // Arrange
        let value = 7
        
        // Act
        let sut = value.asDouble
        
        // Assert
        #expect(sut == 7.0)
    }
    
    @Test
    func testAsTimeString() {
        // Arrange
        let value = 125 // 2 min 5 sec
        
        // Act
        let sut = value.asTimeString
        
        // Assert
        #expect(sut == "2:05")
    }
    
    @Test
    func testAsTimeStringWithZero() {
        // Arrange
        let value = 0
        
        // Act
        let sut = value.asTimeString
        
        // Assert
        #expect(sut == "0:00")
    }
}
