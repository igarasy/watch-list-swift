//
//  TestUtilities.swift
//  WatchListTests
//
//  Created by lucas.igarashi on 30/10/25.
//

import Foundation
import SwiftData
@testable import WatchList

enum TestData {
    static let movies: [(title: String, genre: Genre)] = [
        ("Inception", .action),
        ("Interstellar", .comedy),
        ("La La Land", .musical)
    ]
}

@MainActor
func makeInMemoryModelContainer() throws -> ModelContainer {
    let schema = Schema([Movie.self])
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    return try ModelContainer(for: schema, configurations: config)
}

@MainActor
func seedMovies(into context: ModelContext, count: Int = TestData.movies.count) {
    for i in 0..<min(count, TestData.movies.count) {
        let m = Movie(title: TestData.movies[i].title,
                      genre: TestData.movies[i].genre)
        context.insert(m)
    }
    try? context.save()
}

