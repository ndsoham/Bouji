//
//  FormalWearViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class FormalWearViewController: UIViewController {
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
        self.view.backgroundColor = .black
    }
    //MARK: - set up search controller 
    //MARK: - set up tab bar
    func setupTabBar() {
        let item = UITabBarItem(title: "Formal", image: UIImage(systemName: "florinsign"), selectedImage: UIImage(systemName: "florinsign"))
        self.tabBarItem = item
    }
}

