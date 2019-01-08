//
//  MoviesPresenter.swift
//  Tally
//
//  Created by Bruce McTigue on 12/31/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

extension Movies {
    struct Presenter: PresenterProtocol {
        typealias Model = Movie
        typealias ViewModel = Movies.ViewModel
        private var models: [Model]
        private var dynamicModels: DynamicValue<[ViewModel]> = DynamicValue([ViewModel]())
        
        init(_ models: [Model] = [Model]()) {
            self.models = models
            dynamicModels.value = viewModels
        }
        
        var viewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for model in models {
                let displayedModel = ViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, image: "movie_poster")
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        mutating func updateViewModels(_ response: Response<Model>) {
            self.models = response.models
            self.dynamicModels.value = viewModels
        }
        
        func getDynamicModels() -> DynamicValue<[ViewModel]> {
            return dynamicModels
        }
        
        func getModels() -> [Model] {
            return models
        }
    }
}
