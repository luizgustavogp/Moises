//
//  SongsStringsTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 16/06/25.
//

import Testing
@testable import Moises

struct SongsStringsTests {
    
    @Test
    func testLocalizationKeysAreStable() {
        #expect(SongsStrings.title.rawValue == "songs_title")
        #expect(SongsStrings.searchPrompt.rawValue == "search_prompt")
        #expect(SongsStrings.emptyStateTitle.rawValue == "empty_state_title")
        #expect(SongsStrings.emptyStateSubtitle.rawValue == "empty_state_subtitle")
        #expect(SongsStrings.errorGeneric.rawValue == "error_generic")
    }
    
    @Test
    func testLocalizationValuesAreCorrectInEnglish() {
        #expect(SongsStrings.title.localized == "Songs")
        #expect(SongsStrings.searchPrompt.localized == "Search")
        #expect(SongsStrings.emptyStateTitle.localized == "It looks empty around here")
        #expect(SongsStrings.emptyStateSubtitle.localized == "Try changing your search")
        #expect(SongsStrings.errorGeneric.localized == "Something went wrong")
    }
}
