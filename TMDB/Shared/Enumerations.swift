//
//  Enumerations.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

enum MovieFilterState {
    case all
    case favorite
}

enum MovieSortState {
    case none
    case ascending
    case descending
}

enum MovieFavoriteState: Equatable {
    case selected(Int)
    case unSelected(Int)
}

enum MovieDataAdapter {
    enum Result {
        case success([Movie])
    }
}
