//
//  ItemCollectionViewCell.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    private var titleLabel = UILabel()
    private var priceLabel = UILabel()
    private var imageView = UIImageView()
    private var descriptionLabel = UILabel()
    private var safeMargins: UILayoutGuide?
    private var topInset: Double = 10
    private var leftInset: Double = 15
    var name: String?
    var price: String?
    var image: UIImage?
    var itemDescription: String?
    //MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name = nil
        self.price = nil
        self.image = nil
        self.itemDescription = nil
    }
    //MARK: - layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        safeMargins = self.contentView.safeAreaLayoutGuide
        if let safeMargins, let name, let price, let image, let itemDescription {
            // configure the description
            setupDescriptionLabel(itemDescription: itemDescription, safeMargins: safeMargins)
            // configure title
            setupTitleLabel(name: name, safeMargins: safeMargins)
            // configure the image
            setupImageView(image: image, safeMargins: safeMargins)
            // configure the price
            setupPriceLabel(price: price, safeMargins: safeMargins)
        }
    }
    
}
//MARK: - use this to layout subviews
extension  ItemCollectionViewCell {
    func setupTitleLabel(name: String, safeMargins: UILayoutGuide) {
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
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
    }
    func setupDescriptionLabel(itemDescription: String, safeMargins: UILayoutGuide) {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .left
        let descriptionAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white.withAlphaComponent(0.75)
        ]
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.attributedText = NSAttributedString(string: itemDescription, attributes: descriptionAttributes)
        // add to subview
        self.contentView.addSubview(descriptionLabel)
        // add constraints
        descriptionLabel.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor, constant: -topInset).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: self.contentView.frame.height*0.2).isActive = true

    }
    func setupImageView(image: UIImage, safeMargins: UILayoutGuide) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        // add to subview
        self.contentView.addSubview(imageView)
        // add constraints
        imageView.topAnchor.constraint(equalTo: safeMargins.topAnchor, constant: topInset).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -topInset).isActive = true
    }
    func setupPriceLabel(price: String, safeMargins: UILayoutGuide) {
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
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -leftInset).isActive = true
    }
}
