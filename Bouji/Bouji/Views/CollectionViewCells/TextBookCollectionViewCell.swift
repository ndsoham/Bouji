//
//  TextBookCollectionViewCell.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class TextBookCollectionViewCell: UICollectionViewCell {
    private var titleLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var imageView: UIImageView = UIImageView()
    private var authorLabel: UILabel = UILabel()
    private var safeMargins: UILayoutGuide?
    private var topInset: Double = 5
    private var leftInset: Double = 15
    var name: String?
    var price: String?
    var image: UIImage?
    
    //MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - life cyle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name = nil
        self.price = nil
        self.image = nil
    }
    //MARK: - layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        safeMargins = self.contentView.safeAreaLayoutGuide
        if let safeMargins, let name, let price, let image {
            // set up the image
            setupImageView(image: image, safeMargins: safeMargins)
            // set up name
            setupNameLabel(name: name, safeMargins: safeMargins)
            // set up price
            setupPriceLabel(price: price, safeMargins: safeMargins)
           
        }
    }
    
    
}
//MARK: - use this to layout subviews
extension TextBookCollectionViewCell {
    // image view
    func setupImageView(image: UIImage, safeMargins: UILayoutGuide) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        // add to subview
        self.contentView.addSubview(imageView)
        // add constraints
        imageView.topAnchor.constraint(equalTo: safeMargins.topAnchor, constant: topInset).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        // set up later
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    // name
    func setupNameLabel(name: String, safeMargins: UILayoutGuide) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        let titleAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]
        titleLabel.attributedText = NSAttributedString(string: name, attributes: titleAttributes)
        titleLabel.lineBreakMode = .byTruncatingTail
        // add to subview
        self.contentView.addSubview(titleLabel)
        // add constraints
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: topInset).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.numberOfLines = 0
    }
    // price
    func setupPriceLabel(price: String, safeMargins: UILayoutGuide){
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let priceAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white.withAlphaComponent(0.75)
        ]
        priceLabel.attributedText = NSAttributedString(string: price, attributes: priceAttributes)
        // add to subview
        self.contentView.addSubview(priceLabel)
        // add constraints
        priceLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor, constant: -topInset).isActive = true
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topInset).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
    }
    
}
