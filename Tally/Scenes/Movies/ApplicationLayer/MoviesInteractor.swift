//
//  MoviesInteractor.swift
//  Tally
//
//  Created by Bruce McTigue on 12/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

extension Movies {
    final class Interactor<ServProtocol: ServiceProtocol>: InteractorProtocol {
        
        typealias Model = Movie
        typealias Presenter =  Movies.Presenter
        
        private var service: ServProtocol
        private var presenter: Presenter
        private var state: MovieFilterState
        
        init(_ service: ServProtocol, presenter: Presenter, state: MovieFilterState) {
            self.service = service
            self.presenter = presenter
            self.state = state
        }
        
        func fetchItems(_ request: Request) {
            service.fetchItems(request) { [weak self] models in
                let models = models as! [Model]
                if let self = self {
                    let filteredModels = self.filterModelsByState(models, state: self.state)
                    let response = Response(models: filteredModels)
                    self.presenter.updateViewModels(response)
                }
            }
        }
        
        private func filterModelsByState(_ models: [Model], state: MovieFilterState) -> [Model] {
            var filteredModels = models
//            switch state {
//            case .all:
//                filteredModels = models.filter { $0.wantToSee == false }
//            case .wantToSee:
//                filteredModels = models.filter { $0.wantToSee == true }
//            }
            return filteredModels
        }
    }
}
