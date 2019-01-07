//
//  UnboxDataAdapter.swift
//  Tally
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import Unbox

struct UnboxDataAdapter<Model: Unboxable>: DataAdapterProtocol {
    func itemsFromData(_ data: Data, completionHandler: @escaping (DataAdapter.Result<Model>) -> Void) {
        var items = [Model]()
        do {
            items = try unbox(data: data)
            completionHandler(.success(items))
        } catch {
            completionHandler(.error(.conversionFailed))
        }
    }
}
