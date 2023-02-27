//
//  Protocols.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/27/23.
//  Copyright © 2023 tiguer. All rights reserved.
//

import Foundation
import Tiguer

public protocol PresenterDecorator: PresenterProtocol {
    func filterModelsByState(_ state: MovieFilterState)
    func sortModelsByState(_ state: MovieSortState)
    func updateFavorites(_ state: SelectionState)
    func getFavorites() -> Set<String>
    func getModels() -> [Model]
}

public protocol InteractorPresenter: InteractorProtocol {
    func filterModelsByState(_ state: MovieFilterState)
    func sortModelsByState(_ state: MovieSortState)
    func updateFavorites(_ state: SelectionState)
    func getFavorites() -> Set<String>
}
