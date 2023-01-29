//
//  SearchResult.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit
struct SearchResult: Codable {
    var product: ProductStruct
    var offers: OffersStruct
}

struct ProductStruct: Codable {
    var title: String
    var description: String?
    var main_image: URL
}

struct OffersStruct: Codable {
    var primary: PrimaryStruct
}

struct PrimaryStruct: Codable {
    var price: Double
}
