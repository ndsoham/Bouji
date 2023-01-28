//
//  ViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupChildren()
        configureSelf()
    }
    //MARK: - configure self
    func configureSelf(){
        self.tabBar.backgroundColor = .black
    }
    //MARK: - setup the children
    func setupChildren() {
        // instantiate the view controllers
        let formalVC = FormalWearViewController()
        let casualVC = CasualWearViewController()
        let textBkVC = TextbooksViewController()
        let roomsVC = RoomsViewController()
        // add children
        self.addChild(formalVC)
        self.addChild(casualVC)
        self.addChild(textBkVC)
        self.addChild(roomsVC)
        // inform view controllers
        formalVC.didMove(toParent: self)
        casualVC.didMove(toParent: self)
        textBkVC.didMove(toParent: self)
        roomsVC.didMove(toParent: self)
        // add view controllers
        self.viewControllers = [formalVC, casualVC, textBkVC, roomsVC]
        self.view.backgroundColor = .black
    }

}

