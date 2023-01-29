//
//  ResultsViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

protocol PostDelegate {
    func didFillOutPost(image: UIImage, itemTitle: String, price: String, itemDescription: String)
}
class PostViewController: UIViewController {
    private var scrollView: UIScrollView = UIScrollView()
    private var imageView: UIImageView = UIImageView()
    private var titleTextField: UITextField = UITextField()
    private var priceTextField: UITextField = UITextField()
    private var descriptionTextField: UITextField = UITextField()
    private var sellerProfilePicture: UIImageView = UIImageView()
    private var safeMargins: UILayoutGuide?
    private var leftInset: Double = 15
    private var topInset: Double = 10
    private var sellerView: UIView = UIView()
    private var textStack: UIStackView = UIStackView()
    private var sellerTextField: UITextField = UITextField()
    private var sellerNumberLabel: UITextField = UITextField()
    var image: UIImage?
    var delegate: PostDelegate?
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        setupNavBar()
//        registerKeyboardNotification()
    }
//    //MARK: - register keyboard notification
//    func registerKeyboardNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(adjustScrollView), name: UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(resetScrollView), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    //MARK: - adjust scrollview
//    @objc func adjustScrollView() {
//        UIView.animate(withDuration: 0.5, delay: 0) {
//            self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentOffset.y+150)
//        }
//    }
//    //MARK: - adjust scrollview back
//    @objc func resetScrollView() {
//        UIView.animate(withDuration: 0.5, delay: 0) {
//            self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentOffset.y-150)
//        }
//    }
    //MARK: - set up nav bar
    func setupNavBar() {
        if let navigationController {
            navigationController.navigationBar.prefersLargeTitles = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: UIAction(handler: { action in
                if !(self.titleTextField.text?.isEmpty ?? false) && !(self.priceTextField.text?.isEmpty ?? false) && !(self.descriptionTextField.text?.isEmpty ?? false) && !(self.sellerTextField.text?.isEmpty ?? false) && !(self.sellerNumberLabel.text?.isEmpty ?? false) {
                    navigationController.popViewController(animated: true)
                    self.delegate?.didFillOutPost(image: self.image!, itemTitle: self.titleTextField.text!, price: self.priceTextField.text!, itemDescription: self.descriptionTextField.text!)
                } else {
                    self.view.endEditing(true)
                    let alert = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
                
            }))
        }
    }
    //MARK: - layout subviews
    func layoutSubviews() {
        safeMargins = self.view.safeAreaLayoutGuide
        // set up scroll
        setupScrollView()
        // setup the image view
        setupImageView()
        // setup the item title
        setupItemTitle()
        // setup description
        setupDescriptionLabel()
        // setup the price label
        setupPriceLabel()
        // setup the seller button
        setupSellerView()
        
        
    }
}
//MARK: - use this to layout subviews
extension PostViewController {
    func setupScrollView() {
        if let safeMargins {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.isScrollEnabled = true
            scrollView.isUserInteractionEnabled = true
            scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*2)
            // add to subview
            self.view.addSubview(scrollView)
            // add constraints
            scrollView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor).isActive = true
        }
    }
    func setupImageView() {
        if let image {
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 15
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = image
            // add to subviews
            scrollView.addSubview(imageView)
            // add constraints
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leftInset).isActive = true
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -leftInset).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height*0.33).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30).isActive = true
        }
    }
    func setupItemTitle() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.white
        ]
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: titleAttributes)
        titleTextField.textAlignment = .left
        // add to subview
        scrollView.addSubview(titleTextField)
        // add constraints
        titleTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: topInset).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leftInset).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -leftInset).isActive = true
        
    }
    func setupPriceLabel(){
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        let priceAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]
        priceTextField.attributedPlaceholder = NSAttributedString(string: "$ Price", attributes: priceAttributes)
        priceTextField.textAlignment = .left
        // add to subview
        scrollView.addSubview(priceTextField)
        // add constraints
        priceTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 5).isActive = true
        priceTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leftInset).isActive = true
        priceTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        //
    }
    func setupDescriptionLabel() {
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        let descriptionAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.white.withAlphaComponent(0.75)
        ]
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: descriptionAttributes)
        descriptionTextField.textAlignment = .left
        // add to subviews
        scrollView.addSubview(descriptionTextField)
        // add constraints
        descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leftInset).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -leftInset).isActive = true
        
        
    }
    func setupSellerView() {
        
            sellerView.backgroundColor = UIColor(named: "menuColor")
            sellerView.translatesAutoresizingMaskIntoConstraints = false
            sellerView.layer.masksToBounds = true
            sellerView.layer.cornerRadius = 15
            // add to subview
            scrollView.addSubview(sellerView)
            // add constraints
            sellerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leftInset).isActive = true
            sellerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -leftInset).isActive = true
            sellerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            sellerView.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: topInset).isActive = true
            // set up the button
            sellerProfilePicture.image = UIImage(named: "Tamu Logo")
            sellerProfilePicture.translatesAutoresizingMaskIntoConstraints = false
            // add to subview
            sellerView.addSubview(sellerProfilePicture)
            // add constraints
            sellerProfilePicture.leadingAnchor.constraint(equalTo: sellerView.leadingAnchor, constant: leftInset).isActive = true
            sellerProfilePicture.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor).isActive = true
            sellerProfilePicture.heightAnchor.constraint(equalToConstant: 65).isActive = true
            sellerProfilePicture.widthAnchor.constraint(equalToConstant: 65).isActive = true
            sellerProfilePicture.layer.masksToBounds = true
            sellerProfilePicture.layer.cornerRadius = 65/2
            sellerProfilePicture.layer.borderColor = UIColor.white.cgColor
            sellerProfilePicture.layer.borderWidth = 0.5
            // configure the text stack
            textStack.axis = .vertical
            textStack.alignment = .leading
            textStack.distribution = .equalSpacing
            textStack.translatesAutoresizingMaskIntoConstraints = false
            // add to view
            sellerView.addSubview(textStack)
            // add constraints
            textStack.leadingAnchor.constraint(equalTo: sellerProfilePicture.trailingAnchor, constant: leftInset).isActive = true
            textStack.trailingAnchor.constraint(equalTo: sellerView.trailingAnchor, constant: -leftInset).isActive = true
            textStack.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor).isActive = true
            // configure the two labels
            let sellerAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
            sellerTextField.translatesAutoresizingMaskIntoConstraints = false
            sellerTextField.textAlignment = .left
            sellerTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: sellerAttributes)
            textStack.addArrangedSubview(sellerTextField)
            let numberAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor: UIColor.white.withAlphaComponent(0.75)
            ]
            sellerNumberLabel.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: numberAttributes)
            textStack.addArrangedSubview(sellerNumberLabel)
        
        
    }
}
