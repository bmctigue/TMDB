//
//  Protocols.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis
import Tiguer

protocol CacheProtocol {
    associatedtype CacheObject
    func setObject<CacheObject>(_ object: CacheObject, key: String)
    func getObject<CacheObject>(_ key: String) -> CacheObject?
    func removeObject(_ key: String)
}
