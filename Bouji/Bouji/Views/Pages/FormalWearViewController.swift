//
//  FormalWearViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class FormalWearViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var safeMargins: UILayoutGuide?
    private var numberOfCells: Int = 5
    private var numberOfSections: Int = 3
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
        layoutSubviews()
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
    //MARK: - add subview
    func layoutSubviews() {
        safeMargins = self.view.safeAreaLayoutGuide
        if let safeMargins {
            // set up the collection view
            setupCollectionView(safeMargins: safeMargins)
        }
    }
}
//MARK: - data source
extension FormalWearViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.price = "$69.42"
        cell.itemDescription = "Premium Silk"
        cell.name = "Excite"
        cell.image = UIImage(named: "banana")
        return cell
    }
}
//MARK: - delegate
extension FormalWearViewController: UICollectionViewDelegate {
    
}
//MARK: - flow delegate
extension FormalWearViewController: UICollectionViewDelegateFlowLayout {
    
}
//MARK: - layout each subview
extension FormalWearViewController {
    func setupCollectionView(safeMargins: UILayoutGuide) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 10, height: self.view.frame.height/CGFloat(numberOfSections))
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = CGSize(width: self.view.frame.width - 10, height: 5)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        // configure
        if let collectionView {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.dataSource = self
            // register cell
            collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCollectionViewCell")
            // add to subview
            self.view.addSubview(collectionView)
            // add constraints
            collectionView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        }
    }
}
