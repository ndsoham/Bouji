//
//  CasualWearViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class CasualWearViewController: UIViewController {
    //MARK: - inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
    //MARK: - configure self
    func configureSelf() {
        self.view.backgroundColor = .white
    }
    //MARK: - setup tab bar
    func setupTabBar() {
        let item = UITabBarItem(title: "Casual", image: UIImage(systemName: "tshirt"), selectedImage: UIImage(systemName: "tshirt"))
        self.tabBarItem = item
    }
}
