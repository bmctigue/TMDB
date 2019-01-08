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
        
        init(_ service: ServProtocol, presenter: Presenter) {
            self.service = service
            self.presenter = presenter
        }
        
        func fetchItems(_ request: Request) {
            service.fetchItems(request) { [weak self] models in
                let models = models as! [Model]
                if let self = self {
                    let response = Response(models: models)
                    self.presenter.updateViewModels(response)
                }
            }
        }
    }
}
