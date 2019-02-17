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
    final class Interactor<Model, Presenter: PresenterProtocol, Service: ServiceProtocol>: Tiguer.Interactor<Model, Presenter, Service> {
        
        override func fetchItems(_ request: Request, url: URL) {
            service.fetchItems(request, url: url) { [weak self] models in
                let models = models as! [Presenter.Model]
                if let self = self {
                    let response = Response(models)
                    self.presenter.updateViewModels(response)
                }
            }
        }
    }
}
