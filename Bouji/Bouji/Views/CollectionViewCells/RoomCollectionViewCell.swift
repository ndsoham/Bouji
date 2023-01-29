//
//  RoomCollectionViewCell.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    private var titleLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var numBedsLabel: UILabel = UILabel()
    private var imageView: UIImageView = UIImageView()
    private var safeMargins: UILayoutGuide?
    private var topInset: Double = 10
    private var leftInset: Double = 15
    var title: String?
    var price: String?
    var image: UIImage?
    var numBeds: String?
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
        self.title = nil
        self.price = nil
        self.image = nil
        self.numBeds = nil
    }
    //MARK: - layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        safeMargins = self.contentView.safeAreaLayoutGuide
        if let safeMargins, let image, let title, let numBeds, let price{
            // configure the beds
            setUpNumBedsLabel(numBeds: numBeds, safeMargins: safeMargins)
            // configure price
            setupPriceLabel(price: price, safeMargins: safeMargins)
            // configure the title
            setupTitleLabel(name: title, safeMargins: safeMargins)
            // configure the image
            setupImageView(image: image, safeMargins: safeMargins)
        }
    }
    
}

extension RoomCollectionViewCell {
    //MARK: - image view
    func setupImageView(image: UIImage, safeMargins: UILayoutGuide) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        // add to subview
        self.contentView.addSubview(imageView)
        // add constraints
        imageView.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        imageView.topAnchor.constraint(equalTo: safeMargins.topAnchor, constant: topInset).isActive = true
        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -topInset).isActive = true

    }
    //MARK: - title
    func setupTitleLabel(name: String, safeMargins: UILayoutGuide) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        let titleAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]
        titleLabel.attributedText = NSAttributedString(string: name, attributes: titleAttributes)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 0
        // add to subview
        self.contentView.addSubview(titleLabel)
        // add constraints
        titleLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: numBedsLabel.topAnchor).isActive = true
        
    }
    //MARK: - num beds
    func setUpNumBedsLabel(numBeds: String, safeMargins: UILayoutGuide) {
        numBedsLabel.translatesAutoresizingMaskIntoConstraints = false
        numBedsLabel.textAlignment = .left
        let numBedsAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white.withAlphaComponent(0.75)
        ]
        numBedsLabel.attributedText = NSAttributedString(string: numBeds, attributes: numBedsAttributes)
        // add to subview
        self.contentView.addSubview(numBedsLabel)
        // add constraints
        numBedsLabel.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor, constant: -topInset).isActive = true
        numBedsLabel.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor, constant: leftInset).isActive = true
        numBedsLabel.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor, constant: -leftInset).isActive = true
       }
    //MARK: - price
    func setupPriceLabel(price: String, safeMargins: UILayoutGuide) {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .right
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
        priceLabel.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor, constant: -topInset).isActive = true
        
       }
}
