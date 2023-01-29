//
//  RoomsViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController {
    private var onCampusCollectionView: UICollectionView?
    private var offCampusCollectionView: UICollectionView?
    private var onCampusLabel = UILabel()
    private var onCampusRooms: [Any] = []
    private var offCampusRooms: [Any] = []
    private var offCampusLabel = UILabel()
    private var safeMargins: UILayoutGuide?
    private var activityIndicator = UIActivityIndicatorView()
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        setupNavigationBar()
        layoutSubviews()
    }
    //MARK: - configure self
    func configureSelf() {
        self.view.backgroundColor = .systemBackground
    }
    //MARK: - setup nav bar
    func setupNavigationBar() {
        if let navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.sizeToFit()
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationItem.title = "Rooms"
        }
    }
    //MARK: - layout subviews
    func layoutSubviews() {
        
    }
    
}
//MARK: - data source
extension RoomsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == onCampusCollectionView {
            return onCampusRooms.count
        }
        else if collectionView == offCampusCollectionView {
            return offCampusRooms.count
        }
        return -1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.7, height: self.view.frame.height/3.0)

    }
    
}
//MARK: - layout subviews
extension RoomsViewController {
    func setupOnCampusCollectionView() {
        if let safeMargins{
            onCampusCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
            if let onCampusCollectionView {
                onCampusCollectionView.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.startAnimating()
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                // add to subviews
                onCampusCollectionView.addSubview(activityIndicator)
                // add constraints
                activityIndicator.centerXAnchor.constraint(equalTo: onCampusCollectionView.centerXAnchor).isActive = true
                activityIndicator.centerYAnchor.constraint(equalTo: onCampusCollectionView.centerYAnchor).isActive = true
                // configure
                onCampusCollectionView.translatesAutoresizingMaskIntoConstraints = false
                onCampusCollectionView.dataSource = self
                onCampusCollectionView.delegate = self
                // register
                onCampusCollectionView.register(TextBookCollectionViewCell.self, forCellWithReuseIdentifier: "textbookCollectionViewCell")
                // add to subviews
                self.view.addSubview(onCampusCollectionView)
                // constrain
                onCampusCollectionView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
                onCampusCollectionView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
                onCampusCollectionView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
                onCampusCollectionView.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
            }
        }
    }
}
