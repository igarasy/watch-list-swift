//
//  Genre.swift
//  WatchList
//
//  Created by lucas.igarashi on 28/10/25.
//

import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable{
    var id: Int {
        rawValue
    }
    case action = 1
    case comedy = 2
    case crime = 3
    case documentary = 4
    case drama = 5
    case fantasy = 6
    case kids = 7
    case musical = 8
    case scifi = 9
    case romance = 10
    case thiller = 11
    case western = 12
}

extension Genre{
    var name: String{
        switch self{
            
        case .action:
            "Action"
        case .comedy:
            "Comedy"
        case .crime:
            "Crime"
        case .documentary:
            "Documentary"
        case .drama:
            "Drama"
        case .fantasy:
            "Fantasy"
        case .kids:
            "Kids"
        case .musical:
            "Musical"
        case .scifi:
            "Sci-Fi"
        case .romance:
            "Romance"
        case .thiller:
            "Thiller"
        case .western:
            "Western"
        }
    }
}
