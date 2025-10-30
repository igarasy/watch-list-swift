//
//  ContentViewTests.swift
//  WatchListTests
//
//  Created by lucas.igarashi on 30/10/25.
//

import XCTest
import SwiftUI
import SwiftData
@testable import WatchList

@MainActor
final class ContentViewTests: XCTestCase {

    func test_emptyList_showsEmptyListView() throws {
        let container = try makeInMemoryModelContainer()
        let view = ContentView()
            .modelContainer(container)

        let hosting = UIHostingController(rootView: view)
        XCTAssertNotNil(hosting.view)
    }

    func test_listWithItems_showsRandomButtonAndRows() throws {
        let container = try makeInMemoryModelContainer()
        let context = container.mainContext
        seedMovies(into: context, count: 3)

        let view = ContentView()
            .modelContainer(container)

        let hosting = UIHostingController(rootView: view)
        XCTAssertNotNil(hosting.view)

        let fetch = FetchDescriptor<Movie>()
        let fetched = try context.fetch(fetch)
        XCTAssertEqual(fetched.count, 3)
    }

    func test_swipeToDelete_fromModelContext() throws {
        let container = try makeInMemoryModelContainer()
        let context = container.mainContext
        seedMovies(into: context, count: 2)

        let fetch = FetchDescriptor<Movie>()
        var fetched = try context.fetch(fetch)
        XCTAssertEqual(fetched.count, 2)

        if let first = fetched.first {
            context.delete(first)
            try context.save()
        }

        fetched = try context.fetch(fetch)
        XCTAssertEqual(fetched.count, 1)
    }
}
