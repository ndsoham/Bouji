//
//  RoomsViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController {
    private var scrollView: UIScrollView = UIScrollView()
    private var onCampusCollectionView: UICollectionView?
    private var offCampusCollectionView: UICollectionView?
    private var onCampusLabel: UILabel?
    private var onCampusRooms: [Room] = Room.onCampusRooms
    private var offCampusRooms: [Room] = Room.offCampusRooms
    private var offCampusLabel: UILabel?
    private var safeMargins: UILayoutGuide?
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    private let sepLabelAttributes: [NSAttributedString.Key:Any] = [
        .font:UIFont.boldSystemFont(ofSize: 24),
        .foregroundColor:UIColor.gray
    ]
    private let numberOfSections = 2
    private var imagePicker: UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.mediaTypes = ["public.image"]
        picker.sourceType = .photoLibrary
        return picker
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
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { action in
                self.present(self.imagePicker, animated: true)
            }))
        }
    }
    //MARK: - layout subviews
    func layoutSubviews() {
        // set up on campus
        safeMargins = self.view.safeAreaLayoutGuide
        // layout the scroll view
        if let safeMargins {
            // set up scroll view
            setupScrollView(safeMargins: safeMargins)
            // set up on campus label
            setupOnCampusLabel()
            // layout on campus collection view
            setupOnCampusCollectionView()
            // set up off campus label
            setupOffCampusLabel()
            // set up off campus collection vie
            setupOffCampusCollectionView()
            
        }
    }
    
}
//MARK: - data source
extension RoomsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roomCollectionViewCell", for: indexPath) as! RoomCollectionViewCell
        if cell.image == nil, cell.numBeds == nil, cell.title == nil, cell.price == nil {
            if collectionView == onCampusCollectionView {
                cell.image = onCampusRooms[indexPath.row].image
                cell.numBeds = "Sleeps \(onCampusRooms[indexPath.row].numBeds)"
                cell.title = onCampusRooms[indexPath.row].name
                cell.price = "$\(onCampusRooms[indexPath.row].price)/night"
                return cell
            }
            else if collectionView == offCampusCollectionView {
                cell.image = offCampusRooms[indexPath.row].image
                cell.numBeds = "Sleeps \(offCampusRooms[indexPath.row].numBeds)"
                cell.title = offCampusRooms[indexPath.row].name
                cell.price = "$\(round(offCampusRooms[indexPath.row].price*100)/100)/night"
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.7, height: self.view.frame.height/3.0)
        
    }
    
}
//MARK: - handle selections
extension RoomsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == onCampusCollectionView {
            let detailVc = DetailViewController()
            detailVc.image = onCampusRooms[indexPath.row].image
            detailVc.itemTitle = onCampusRooms[indexPath.row].name
            detailVc.itemDescription = "Sleeps \(onCampusRooms[indexPath.row].numBeds)"
            detailVc.sellerIcon = UIImage(named: "Tamu Logo")
            detailVc.price = "$\(round(onCampusRooms[indexPath.row].price*100)/100)/night"
            detailVc.sellerName = "Reveille X"
            detailVc.sellerNumber = "(979) 845-3211"
            navigationController?.pushViewController(detailVc, animated: true)
        } else if collectionView == offCampusCollectionView {
            let detailVc = DetailViewController()
            detailVc.image = offCampusRooms[indexPath.row].image
            detailVc.itemTitle = offCampusRooms[indexPath.row].name
            detailVc.itemDescription = "Sleeps \(offCampusRooms[indexPath.row].numBeds)"
            detailVc.sellerIcon = offCampusRooms[indexPath.row].image
            detailVc.price = "$\(round(offCampusRooms[indexPath.row].price*100)/100)/night"
            detailVc.sellerName = offCampusRooms[indexPath.row].name
            detailVc.sellerNumber = "(979) 845-3211"
            navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}
//MARK: - layout subviews
extension RoomsViewController {
    //MARK: - setup the scrollview
    func setupScrollView(safeMargins: UILayoutGuide) {
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
    //MARK: - Section Heading
    func setupOnCampusLabel() {
        // configure
        onCampusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let onCampusLabel {
            onCampusLabel.translatesAutoresizingMaskIntoConstraints = false
            onCampusLabel.attributedText = NSAttributedString(string: "On Campus", attributes: sepLabelAttributes)
            scrollView.addSubview(onCampusLabel)
            // add constraints
            onCampusLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            onCampusLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            onCampusLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
        
    }
    //MARK: - set up on campus
    func setupOnCampusCollectionView() {
        onCampusCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        if let onCampusCollectionView {
            onCampusCollectionView.translatesAutoresizingMaskIntoConstraints = false
            // configure
            onCampusCollectionView.dataSource = self
            onCampusCollectionView.delegate = self
            // register
            onCampusCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: "roomCollectionViewCell")
            // add to subviews
            scrollView.addSubview(onCampusCollectionView)
            // constrain
            onCampusCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            onCampusCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            
            onCampusCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let onCampusLabel {
                onCampusCollectionView.topAnchor.constraint(equalTo: onCampusLabel.bottomAnchor).isActive = true
            }
        }
        
    }
    //MARK: - set up off campus label
    func setupOffCampusLabel() {
        offCampusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        if let offCampusLabel, let onCampusCollectionView {
            offCampusLabel.translatesAutoresizingMaskIntoConstraints = false
            offCampusLabel.attributedText = NSAttributedString(string: "Off Campus", attributes: sepLabelAttributes)
            scrollView.addSubview(offCampusLabel)
            // add constraints
            offCampusLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            offCampusLabel.topAnchor.constraint(equalTo: onCampusCollectionView.bottomAnchor).isActive = true
            offCampusLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        }
    }
    //MARK: - set up off campus collection view
    func setupOffCampusCollectionView() {
        offCampusCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3.0), collectionViewLayout: layout)
        if let offCampusCollectionView {
            offCampusCollectionView.translatesAutoresizingMaskIntoConstraints = false
            // configure
            offCampusCollectionView.dataSource = self
            offCampusCollectionView.delegate = self
            // register
            offCampusCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: "roomCollectionViewCell")
            // add to subviews
            scrollView.addSubview(offCampusCollectionView)
            // constrain
            offCampusCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            offCampusCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0).isActive = true
            offCampusCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            if let offCampusLabel {
                offCampusCollectionView.topAnchor.constraint(equalTo: offCampusLabel.bottomAnchor).isActive = true
            }
        }
        
    }

}
//MARK: - image picker
extension RoomsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let postViewController = PostViewController()
        if let image = info[.editedImage] as? UIImage {
            postViewController.image = image
            postViewController.delegate = self
            navigationController?.pushViewController(postViewController, animated: true)
        }
    }
}
//MARK: - post delegate
extension RoomsViewController: PostDelegate {
    func didFillOutPost(image: UIImage, itemTitle: String, price: String, itemDescription: String) {
        let newRoom = Room(name: itemTitle, price: Double(price) ?? 0, numBeds: Int(itemDescription) ?? 2, image: image)
        self.offCampusRooms.append(newRoom)
        DispatchQueue.main.async {
            self.offCampusCollectionView?.reloadData()
        }
    }
}
