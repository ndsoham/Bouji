//
//  TabBarController+Contraints.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

extension TabBarController {
    func setUpConstraints(vc1: UIViewController, vc2: UIViewController, vc3: UIViewController, vc4: UIViewController, safeMargins: UILayoutGuide) {
        // formal vc
        vc1.view.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
        vc1.view.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
        vc1.view.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        vc1.view.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
        // casual vc
        vc2.view.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
        vc2.view.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
        vc2.view.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        vc2.view.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
        // text bk vc
        vc3.view.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
        vc3.view.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
        vc3.view.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        vc3.view.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
        // rooms vc
        vc4.view.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
        vc4.view.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
        vc4.view.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        vc4.view.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
    }
}
