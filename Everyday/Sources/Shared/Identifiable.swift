//
//  Identifiable.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 4..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

protocol Identifiable{
    var id: UUID { get }
}

extension Identifiable{
    func isIdentical(to other: Self) -> Bool {
        return id == other.id
    }
}
