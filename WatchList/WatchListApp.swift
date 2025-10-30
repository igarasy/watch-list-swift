//
//  WatchListApp.swift
//  WatchList
//
//  Created by lucas.igarashi on 28/10/25.
//

import SwiftUI
import SwiftData

@main
struct WatchListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:Movie.self)
        }
    }
}
