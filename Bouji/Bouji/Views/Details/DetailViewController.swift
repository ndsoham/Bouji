//
//  DetailViewController.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit
import MessageUI
class DetailViewController: UIViewController {
    private var imageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var sellerButton: UIButton = UIButton()
    private var safeMargins: UILayoutGuide?
    private var leftInset: Double = 15
    private var topInset: Double = 10
    private var sellerView: UIView = UIView()
    private var textStack: UIStackView = UIStackView()
    private var sellerNameLabel: UILabel = UILabel()
    private var sellerNumberLabel: UILabel = UILabel()
    private var sellerInfoLabel: UILabel = UILabel()
    private let sepLabelAttributes: [NSAttributedString.Key:Any] = [
        .font:UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: UIColor.white
    ]
    var image: UIImage? 
    var itemTitle: String?
    var price: String?
    var itemDescription: String?
    var sellerIcon: UIImage?
    var sellerName: String?
    var sellerNumber: String?
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        setupNavigationBar()
    }
    //MARK: - set up nav bar
    func setupNavigationBar() {
        if let navigationController {
            navigationController.navigationBar.prefersLargeTitles = false
        }
    }
    //MARK: - layout subviews
    func layoutSubviews() {
        safeMargins = self.view.safeAreaLayoutGuide
        // setup the image view
        setupImageView()
        // setup the item title
        setupItemTitle()
        // setup description
        setupDescriptionLabel()
        // setup the price label
        setupPriceLabel()
        // setup seller info
        setupSellerInfoLabel()
        // setup the seller view
        setupSellerView()
        
       
        
    }
}
//MARK: - use this to layout subviews
extension DetailViewController {
    func setupImageView() {
        if let safeMargins {
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 15
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = image
            // add to subviews
            self.view.addSubview(imageView)
            // add constraints
            imageView.topAnchor.constraint(equalTo: safeMargins.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            imageView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height*0.33).isActive = true
        }
    }
    func setupItemTitle() {
        if let safeMargins, let itemTitle {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            let titleAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
            titleLabel.attributedText = NSAttributedString(string: itemTitle, attributes: titleAttributes)
            titleLabel.textAlignment = .left
            // add to subview
            self.view.addSubview(titleLabel)
            // add constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: topInset).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            titleLabel.numberOfLines = 0
        }
    }
    func setupPriceLabel(){
        if let safeMargins, let price {
            priceLabel.translatesAutoresizingMaskIntoConstraints = false
            let priceAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.white
            ]
            priceLabel.attributedText = NSAttributedString(string: price, attributes: priceAttributes)
            priceLabel.textAlignment = .left
            // add to subview
            self.view.addSubview(priceLabel)
            // add constraints
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            priceLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            priceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
//
    }
    func setupDescriptionLabel() {
        if let itemDescription, let safeMargins {
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            let descriptionAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.white.withAlphaComponent(0.75)
            ]
            descriptionLabel.attributedText = NSAttributedString(string: itemDescription, attributes: descriptionAttributes)
            descriptionLabel.textAlignment = .left
            // add to subviews
            self.view.addSubview(descriptionLabel)
            // add constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            descriptionLabel.numberOfLines = 0
        }
        
    }
    func setupSellerInfoLabel() {
        if let safeMargins {
            sellerInfoLabel.translatesAutoresizingMaskIntoConstraints = false
            sellerInfoLabel.attributedText = NSAttributedString(string: "Seller", attributes: sepLabelAttributes)
            sellerInfoLabel.textAlignment = .left
            // add to subviews
            self.view.addSubview(sellerInfoLabel)
            // add constraints
            sellerInfoLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            sellerInfoLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            sellerInfoLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: topInset).isActive = true
        }
        
    }
    func setupSellerView() {
        if let safeMargins, let sellerName, let sellerNumber {
//            sellerView.backgroundColor = UIColor(named: "menuColor")
            sellerView.translatesAutoresizingMaskIntoConstraints = false
            sellerView.layer.masksToBounds = true
            sellerView.layer.cornerRadius = 15
            // add to subview
            self.view.addSubview(sellerView)
            // add constraints
            sellerView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
            sellerView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            sellerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            sellerView.topAnchor.constraint(equalTo: sellerInfoLabel.bottomAnchor).isActive = true
            // set up the button
            sellerButton.setBackgroundImage(sellerIcon, for: .normal)
            sellerButton.addTarget(self, action: #selector(handleSellerButtonPressed), for: .touchUpInside)
            sellerButton.translatesAutoresizingMaskIntoConstraints = false
            // add to subview
            sellerView.addSubview(sellerButton)
            // add constraints
            sellerButton.leadingAnchor.constraint(equalTo: sellerView.leadingAnchor).isActive = true
            sellerButton.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor).isActive = true
            sellerButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
            sellerButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
            sellerButton.layer.masksToBounds = true
            sellerButton.layer.cornerRadius = 65/2
            sellerButton.layer.borderColor = UIColor.white.cgColor
            sellerButton.layer.borderWidth = 0.5
            // configure the text stack
            textStack.axis = .vertical
            textStack.alignment = .leading
            textStack.distribution = .equalSpacing
            textStack.translatesAutoresizingMaskIntoConstraints = false
            // add to view
            sellerView.addSubview(textStack)
            // add constraints
            textStack.leadingAnchor.constraint(equalTo: sellerButton.trailingAnchor, constant: leftInset).isActive = true
            textStack.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
            textStack.centerYAnchor.constraint(equalTo: sellerView.centerYAnchor).isActive = true
            // configure the two labels
            let sellerAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
            sellerNameLabel.translatesAutoresizingMaskIntoConstraints = false
            sellerNameLabel.textAlignment = .left
            sellerNameLabel.attributedText = NSAttributedString(string: sellerName, attributes: sellerAttributes)
            print(sellerName)
            textStack.addArrangedSubview(sellerNameLabel)
            let numberAttributes: [NSAttributedString.Key:Any] = [
                .font: UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor: UIColor.white.withAlphaComponent(0.75)
            ]
            sellerNumberLabel.attributedText = NSAttributedString(string: sellerNumber, attributes: numberAttributes)
            textStack.addArrangedSubview(sellerNumberLabel)
        }
        
    }
}
//MARK: - deal with button presses
extension DetailViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            
            print("message canceled")
            
        case.failed :
            
            print("message failed")
            
        case .sent :
            
            print("message sent")
            
        default:
            
            break
            
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleSellerButtonPressed(sender: UIButton) {
        if UIApplication.shared.canOpenURL(URL(string:"sms:\("8885555512")")!) {
            UIApplication.shared.open(URL(string:"sms:\("8885555512")")!, options: [:], completionHandler: nil)
        }
    }
}
