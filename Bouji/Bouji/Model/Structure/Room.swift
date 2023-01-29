//
//  Room.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/29/23.
//

import Foundation
import UIKit

class Room {
    var name: String
    var price: Double
    var numBeds: Int
    var image: UIImage
    init(name: String, price: Double, numBeds: Int, image: UIImage) {
        self.name = name
        self.price = price
        self.numBeds = numBeds
        self.image = image
    }
}

extension Room {
    static let onCampusRooms: [Room] = [
        Room(name: "Clements Hall - Room 267", price: 15, numBeds: 2, image: UIImage(named: "Clements")!),
        Room(name: "Hobby Hall - Room 34", price: 7, numBeds: 1, image: UIImage(named: "Hobby")!),
        Room(name: "Hullaballoo Hall - Room 90", price: 35, numBeds: 1, image: UIImage(named: "Hullaballoo")!),
        Room(name: "Krueger Hall - Room 13", price: 14, numBeds: 1, image: UIImage(named: "Krueger")!),
        Room(name: "Lechner Hall - Room 315", price: 17, numBeds: 2, image: UIImage(named: "Lechner")!),
        Room(name: "Mosher Hall - Room 78", price: 25, numBeds: 2, image: UIImage(named: "Mosher")!),
        Room(name: "Rudder Hall - Room 12", price: 6, numBeds: 2, image: UIImage(named: "Rudder")!),
        Room(name: "Underwood Hall - Room 56", price: 8, numBeds: 2, image: UIImage(named: "Underwood")!)
    ]
    static let offCampusRooms: [Room] = [
        Room(name: "Aspire - Room 816", price: 50, numBeds: 3, image: UIImage(named: "Aspire")!),
        Room(name: "The Junction Cottages and Townhomes - Room 16", price: 30, numBeds: 2, image: UIImage(named: "Junction Cottages and Townhomes")!),
        Room(name: "Northpoint Crossing - Room 6205", price: 27, numBeds: 3, image: UIImage(named: "Northpoint Crossing")!),
        Room(name: "Park West - Room 1738", price: 10, numBeds: 1, image: UIImage(named: "Park West")!),
        Room(name: "Rise at Northgate - Room 4506", price: 28, numBeds: 2, image: UIImage(named: "Rise at Northgate")!),
        Room(name: "The Barracks Townhomes - Room 16", price: 15, numBeds: 2, image: UIImage(named: "The Barracks Townhomes")!),
        Room(name: "The Standard - Room 3112", price: 50, numBeds: 4, image: UIImage(named: "The Standard")!),
        Room(name: "The Woodlands - Room 6823", price: 60, numBeds: 3, image: UIImage(named: "The Woodlands")!)
    ]
}
