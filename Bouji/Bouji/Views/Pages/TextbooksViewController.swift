//
//  TextbooksViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class TextbooksViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var textBooks: [Product] = []
    private var safeMargins: UILayoutGuide?
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        return layout
    }
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        layoutSubviews()
        setupNavigationBar()
        setupDataTask()
    }
    //MARK: - data task
    func setupDataTask() {
        DataGatherer.shared.gatherData(item: "Textbook") { results in
            self.textBooks = results
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    //MARK: - setup nav bar
    func setupNavigationBar() {
        if let navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.sizeToFit()
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationItem.title = "Textbooks"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { action in
                print("im here")
            }))
        }
    }
    //MARK: - configure self
    func configureSelf() {
        self.view.backgroundColor = .systemBackground
    }
    //MARK: - layout subviews
    func layoutSubviews() {
        // setup the collection view
        safeMargins = self.view.safeAreaLayoutGuide
        setupCollectionView()
    }
}
//MARK: - layout subviews
extension TextbooksViewController {
    func setupCollectionView() {
        if let safeMargins {
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
            if let collectionView {
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.startAnimating()
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                // add to subviews
                collectionView.addSubview(activityIndicator)
                // add constraints
                activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
                activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
            // configure
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                collectionView.dataSource = self
                collectionView.delegate = self
            // register
                collectionView.register(TextBookCollectionViewCell.self, forCellWithReuseIdentifier: "textbookCollectionViewCell")
            // add to subviews
                self.view.addSubview(collectionView)
            // constrain
                collectionView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
                collectionView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
                collectionView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
                collectionView.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
            }
        }
    }
}
//MARK: - data source
extension TextbooksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textbookCollectionViewCell", for: indexPath) as! TextBookCollectionViewCell
        if cell.image == nil, cell.price == nil, cell.name == nil {
            cell.image = textBooks[indexPath.row].image
            cell.price = "$\(round(textBooks[indexPath.row].price/3 * 100)/100)/sem"
            cell.name = textBooks[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3, height: self.view.frame.height/4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = DetailViewController()
        detailVc.image = textBooks[indexPath.row].image
        detailVc.itemTitle = textBooks[indexPath.row].name
        detailVc.itemDescription = textBooks [indexPath.row].description
        detailVc.price = "$\(round(textBooks[indexPath.row].price/3 * 100)/100)/sem"
        detailVc.sellerIcon = UIImage(named: "James Daunt")
        detailVc.sellerName = "James Daunt"
        detailVc.sellerNumber = "(800) 843-2665"
        navigationController?.pushViewController(detailVc, animated: true)
    }
}
