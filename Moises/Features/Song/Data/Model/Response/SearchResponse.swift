//
//  SearchResponse.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

struct SearchResponse<T: Decodable>: Decodable {
    let resultCount: Int
    let results: [T]
}

extension SearchResponse where T: Decodable {
    static var empty: SearchResponse<T> {
        .init(resultCount: 0, results: [])
    }
}
