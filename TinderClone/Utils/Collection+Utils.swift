//
//  Collection+Utils.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
