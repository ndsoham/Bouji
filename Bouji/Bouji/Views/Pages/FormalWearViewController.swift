//
//  FormalWearViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class FormalWearViewController: UIViewController {
    private var scrollView: UIScrollView = UIScrollView()
    private var suitsCollectionView: UICollectionView?
    private var suits: [Product] = []
    private var shoesCollectionView: UICollectionView?
    private var shoes: [Product] = []
    private var dressesCollectionView: UICollectionView?
    private var dresses: [Product] = []
    private var tiesCollectionView: UICollectionView?
    private var ties: [Product] = []
    private var safeMargins: UILayoutGuide?
    private var numberOfCells: Int = 5
    private var numberOfSections: Int = 4
    private var suitsLabel: UILabel?
    private var shoesLabel: UILabel?
    private var tiesLabel: UILabel?
    private var dressesLabel: UILabel?
    private var suitsActivityIndicator = UIActivityIndicatorView()
    private var shoesActivityIndicator = UIActivityIndicatorView()
    private var tiesActivityIndicator = UIActivityIndicatorView()
    private var dressesActivityIndicator = UIActivityIndicatorView()
    private let sepLabelAttributes: [NSAttributedString.Key:Any] = [
        .font:UIFont.preferredFont(forTextStyle: .largeTitle),
        .foregroundColor:UIColor.gray
    ]
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        layoutSubviews()
        setupNavigationBar()
       // startDataTask()
    }
    //MARK: - data task
    func startDataTask() {
        DataGatherer.shared.gatherData(item: "Suits") { results in
            print("Acquired suits")
            self.suits = results
            DispatchQueue.main.async {
                self.suitsCollectionView?.reloadData()
                self.suitsActivityIndicator.stopAnimating()
                
            }
        }
        DataGatherer.shared.gatherData(item: "Dress%20Shoes") { results in
            print("Acquired shoes")
            self.shoes = results
            DispatchQueue.main.async {
                self.shoesCollectionView?.reloadData()
                self.shoesActivityIndicator.stopAnimating()
            }
        }
        DataGatherer.shared.gatherData(item: "Ties") { results in
            print("Acquired ties")
            self.ties = results
            DispatchQueue.main.async {
                self.tiesCollectionView?.reloadData()
                self.tiesActivityIndicator.stopAnimating()
            }
        }
        DataGatherer.shared.gatherData(item: "Pantsuits") { results in
            print("Acquired dresses")
            self.dresses = results
            DispatchQueue.main.async {
                self.dressesCollectionView?.reloadData()
                self.dressesActivityIndicator.stopAnimating()
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
            self.navigationItem.title = "Formals"
        }
    }
    //MARK: - configure self
    func configureSelf() {
        self.view.backgroundColor = .systemBackground
    }
    //MARK: - set up search controller 

    //MARK: - add subview
    func layoutSubviews() {
        safeMargins = self.view.safeAreaLayoutGuide
        if let safeMargins {
            // set up the scroll view
            setupScrollView(safeMargins: safeMargins)
            // set up the first label
            setupSuitsLabel()
            // set up the suits collection view
            setupSuitsCollectionView()
            // set up shoes label
            setupShoesLabel()
            // set up the shoes collection view
            setupShoesCollectionView()
            // set up ties label
            setupTiesLabel()
            // set up ties collection view
            setupTiesCollectionView()
            // set up dresses label
            setupDressesLabel()
            // set up dressed content view
            setupDressesCollectionView()
        }
    }
}
//MARK: - data source
extension FormalWearViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suitsCollectionView {
            return suits.count
        }
        else if collectionView == shoesCollectionView {
            return shoes.count
        }
        else if collectionView == tiesCollectionView {
            return ties.count
        }
        else if collectionView == dressesCollectionView {
            return dresses.count
        }
        return -1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == suitsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            if cell.price == nil, cell.itemDescription == nil, cell.name == nil, cell.image == nil{
                cell.price = "$\(round(suits[indexPath.row].price/3 * 100) / 100)/day"
                cell.itemDescription = suits[indexPath.row].description
                cell.name = suits[indexPath.row].name
                cell.image = suits[indexPath.row].image
            }
            return cell
        }
        else if collectionView == shoesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            if cell.price == nil, cell.itemDescription == nil, cell.name == nil, cell.image == nil {
                cell.price = "$\(round(shoes[indexPath.row].price/3 * 100) / 100)/day"
                cell.itemDescription = shoes[indexPath.row].description
                cell.name = shoes[indexPath.row].name
                cell.image = shoes[indexPath.row].image
                return cell
            }
        }
        else if collectionView == tiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            if cell.price == nil, cell.itemDescription == nil, cell.name == nil, cell.image == nil {
                cell.price = "$\(round(ties[indexPath.row].price/3 * 100) / 100)/day"
                cell.itemDescription = ties[indexPath.row].description
                cell.name = ties[indexPath.row].name
                cell.image = ties[indexPath.row].image
                return cell
            }
        }
        else if collectionView == dressesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            if cell.price == nil, cell.itemDescription == nil, cell.name == nil, cell.image == nil {
                cell.price = "$\(round(dresses[indexPath.row].price/3 * 100) / 100)/day"
                cell.itemDescription = dresses[indexPath.row].description
                cell.name = dresses[indexPath.row].name
                cell.image = dresses[indexPath.row].image
                return cell
            }
        }
        
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.6, height: self.view.frame.height/3.0)
    }
}
//MARK: - layout each subview
extension FormalWearViewController {
    //MARK: - scroll view
    func setupScrollView(safeMargins: UILayoutGuide){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: (self.view.frame.height/3.0) * CGFloat(numberOfSections) + (44) * CGFloat(numberOfSections))
        // add to subview
        self.view.addSubview(scrollView)
        // add constraints
        scrollView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
    }
    //MARK: -  suits label
    func setupSuitsLabel() {
        // configure
        suitsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let suitsLabel {
            suitsLabel.translatesAutoresizingMaskIntoConstraints = false
            suitsLabel.attributedText = NSAttributedString(string: "Suits",attributes: sepLabelAttributes)
            scrollView.addSubview(suitsLabel)
            // add constraints
            suitsLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            suitsLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            suitsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            suitsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
    }
    //MARK: - suits collection view
    func setupSuitsCollectionView() {
        
        suitsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        // configure
        if let suitsCollectionView {
            suitsActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            suitsActivityIndicator.startAnimating()
            // add an activity indicator
            suitsCollectionView.addSubview(suitsActivityIndicator)
            // add constraints
            suitsActivityIndicator.centerXAnchor.constraint(equalTo: suitsCollectionView.centerXAnchor).isActive = true
            suitsActivityIndicator.centerYAnchor.constraint(equalTo: suitsCollectionView.centerYAnchor).isActive = true
            suitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
            suitsCollectionView.dataSource = self
            suitsCollectionView.delegate = self
            // register cells and reusable views
            suitsCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCollectionViewCell")
            // add to subview
            scrollView.addSubview(suitsCollectionView)
            // constrain
            suitsCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            suitsCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            suitsCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let suitsLabel {
                suitsCollectionView.topAnchor.constraint(equalTo: suitsLabel.bottomAnchor).isActive = true
            }
        }
    }
    //MARK: - setup shoes label
    func setupShoesLabel() {
        shoesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let shoesLabel, let suitsCollectionView {
            shoesLabel.translatesAutoresizingMaskIntoConstraints = false
            shoesLabel.attributedText = NSAttributedString(string: "Shoes",attributes: sepLabelAttributes)
            scrollView.addSubview(shoesLabel)
            // add constraints
            shoesLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            shoesLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            shoesLabel.topAnchor.constraint(equalTo: suitsCollectionView.bottomAnchor).isActive = true
            shoesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
    }
    //MARK: - shoes collection view
    func setupShoesCollectionView(){
        shoesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        // configure
        if let shoesCollectionView {
            shoesActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            shoesActivityIndicator.startAnimating()
            // add an activity indicator
            shoesCollectionView.addSubview(shoesActivityIndicator)
            // add constraints
            shoesActivityIndicator.centerXAnchor.constraint(equalTo: shoesCollectionView.centerXAnchor).isActive = true
            shoesActivityIndicator.centerYAnchor.constraint(equalTo: shoesCollectionView.centerYAnchor).isActive = true
            shoesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            shoesCollectionView.dataSource = self
            shoesCollectionView.delegate = self
            // register cells and reusable views
            shoesCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCollectionViewCell")
            // add to subview
            scrollView.addSubview(shoesCollectionView)
            // constrain
            shoesCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            shoesCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            shoesCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let shoesLabel {
                shoesCollectionView.topAnchor.constraint(equalTo: shoesLabel.bottomAnchor).isActive = true
            }
        }
    }
    //MARK: - ties label
    func setupTiesLabel() {
        tiesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let tiesLabel, let shoesCollectionView {
            tiesLabel.translatesAutoresizingMaskIntoConstraints = false
            tiesLabel.attributedText = NSAttributedString(string: "Ties",attributes: sepLabelAttributes)
            scrollView.addSubview(tiesLabel)
            // add constraints
            tiesLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            tiesLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            tiesLabel.topAnchor.constraint(equalTo: shoesCollectionView.bottomAnchor).isActive = true
            tiesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
    }
    //MARK: - ties collection view
    func setupTiesCollectionView() {
        tiesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        // configure
        if let tiesCollectionView {
            tiesActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            tiesActivityIndicator.startAnimating()
            // add an activity indicator
            tiesCollectionView.addSubview(tiesActivityIndicator)
            // add constraints
            tiesActivityIndicator.centerXAnchor.constraint(equalTo: tiesCollectionView.centerXAnchor).isActive = true
            tiesActivityIndicator.centerYAnchor.constraint(equalTo: tiesCollectionView.centerYAnchor).isActive = true
            tiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            tiesCollectionView.dataSource = self
            tiesCollectionView.delegate = self
            // register cells and reusable views
            tiesCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCollectionViewCell")
            // add to subview
            scrollView.addSubview(tiesCollectionView)
            // constrain
            tiesCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            tiesCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            tiesCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let tiesLabel {
                tiesCollectionView.topAnchor.constraint(equalTo: tiesLabel.bottomAnchor).isActive = true
            }
        }
        
    }
    //MARK: - set up dresses label
    func setupDressesLabel()  {
        dressesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let dressesLabel, let tiesCollectionView {
            dressesLabel.translatesAutoresizingMaskIntoConstraints = false
            dressesLabel.attributedText = NSAttributedString(string: "Dresses",attributes: sepLabelAttributes)
            scrollView.addSubview(dressesLabel)
            // add constraints
            dressesLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            dressesLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            dressesLabel.topAnchor.constraint(equalTo: tiesCollectionView.bottomAnchor).isActive = true
            dressesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
    }
    //MARK: - dresses collection view
    func setupDressesCollectionView() {
        dressesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        // configure
        if let dressesCollectionView {
            dressesActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            dressesActivityIndicator.startAnimating()
            // add an activity indicator
            dressesCollectionView.addSubview(dressesActivityIndicator)
            // add constraints
            dressesActivityIndicator.centerXAnchor.constraint(equalTo: dressesCollectionView.centerXAnchor).isActive = true
            dressesActivityIndicator.centerYAnchor.constraint(equalTo: dressesCollectionView.centerYAnchor).isActive = true
            dressesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            dressesCollectionView.dataSource = self
            dressesCollectionView.delegate = self
            // register cells and reusable views
            dressesCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCollectionViewCell")
          
            // add to subview
            scrollView.addSubview(dressesCollectionView)
            // constrain
            dressesCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            dressesCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            dressesCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let dressesLabel {
                dressesCollectionView.topAnchor.constraint(equalTo: dressesLabel.bottomAnchor).isActive = true
            }
        }
    }
}
