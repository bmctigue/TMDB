//
//  SelectionManager.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/26/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

extension Tiguer {
    open class SelectionManager<Model> {
        
        let selectionKey = "\(Model.self)"
        
        private var selections: Set<String> = []
        private lazy var cache = BaseCache<Set<String>>()
        
        public init() {
            self.selections = cache.getObject(selectionKey) ?? []
        }
        
        open func updateSelections(_ state: SelectionState) {
            switch state {
            case .selected(let selectionId):
                selections.insert(selectionId)
            case .unSelected(let selectionId):
                selections.remove(selectionId)
            }
            cache.setObject(selections, key: selectionKey)
        }
        
        open func getSelections() -> Set<String> {
            return selections
        }
    }
}
