//
//  Enumerations.swift
//  Tally
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

enum StoreError: Error {
    case fetchDataFailed
}

enum Store {
    enum Result {
        case success(Data)
        case error(StoreError)
    }
}

enum DataAdapterError: Error {
    case conversionFailed
}

enum DataAdapter {
    enum Result<Model> {
        case success([Model])
        case error(DataAdapterError)
    }
}

enum MovieDataAdapter {
    enum Result {
        case success([Movie])
        case error(DataAdapterError)
    }
}
