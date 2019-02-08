//
//  Interactor.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

public final class Interactor<Model, Presenter: PresenterProtocol, ServProtocol: ServiceProtocol>: InteractorProtocol {
    
    private var service: ServProtocol
    private var presenter: Presenter
    
    public init(_ service: ServProtocol, presenter: Presenter) {
        self.service = service
        self.presenter = presenter
    }
    
    public func fetchItems(_ request: Request, url: URL) {
        service.fetchItems(request, url: url) { [weak self] models in
            let models = models as! [Presenter.Model]
            if let self = self {
                let response = Response(models)
                self.presenter.updateViewModels(response)
            }
        }
    }
}
