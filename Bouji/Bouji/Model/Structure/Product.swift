//
//  Product.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class Product {
    var name: String
    var price: Double
    var description: String?
    var image: UIImage
    init(name: String, price: Double, description: String? = "", image: UIImage) {
        self.name = name
        self.price = price
        self.description = description
        self.image = image
    }
}
