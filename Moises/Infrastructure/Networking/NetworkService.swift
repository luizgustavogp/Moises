//
//  NetworkService.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

protocol NetworkService: Sendable {
    func request<T: Decodable>(_ url: URL, retries: Int) async throws -> T
}
