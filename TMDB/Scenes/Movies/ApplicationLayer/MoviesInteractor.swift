//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/11/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer

extension Movies {
    final class Interactor<Model, Presenter: PresenterDecorator, ModelFactory: ModelFactoryProtocol>: Tiguer.Interactor<Model, Presenter, ModelFactory>, InteractorPresenter {}
}

extension Movies.Interactor {
    
    func filterModelsByState(_ state: MovieFilterState) {
        presenter.filterModelsByState(state)
    }
    
    func sortModelsByState(_ state: MovieSortState) {
        presenter.sortModelsByState(state)
    }
    
    func updateFavorites(_ state: SelectionState) {
        presenter.updateFavorites(state)
    }
    
    func getFavorites() -> Set<String> {
        return presenter.getFavorites()
    }
}
