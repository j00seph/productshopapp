//
//  ProductCodable.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import Foundation


struct Product: Codable, Hashable {
    let id, name, category, price: String
    let bgColor: String
}
