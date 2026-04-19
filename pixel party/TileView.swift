//
//  TileView.swift
//  pixel party
//
//  Created by Mitev, Viktor on 18/03/2026.
//

import UIKit

final class TileView: UIView {

    // MARK: - Properties
    private let numberLabel = UILabel()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    var solvedImage: UIImage? = nil {
        didSet { configure() }
    }

    // didSet means configure() runs automatically whenever value is set from outside
    var value: Int = 0 {
        didSet { configure() }
    }

    // MARK: - Init
    // Both inits are required by UIKit — frame init is used when creating in code,
    // coder init is used when loading from storyboard. Both just call commonInit.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Setup
    // Runs once during initialization to style the tile and pin its image and label subviews.
    private func commonInit() {
        layer.cornerRadius = 8
        backgroundColor = .systemGray5
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        numberLabel.textAlignment = .center
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.3
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberLabel)

        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }

    // MARK: - Configure
    // value == 0 is the blank tile it will be invisible
    private func configure() {
        if value == 0 {
            backgroundColor = .clear
            imageView.isHidden = true
            numberLabel.isHidden = true
            return
        }
        
        // image mode
        if let img = solvedImage {
            backgroundColor = .clear
            imageView.image = img
            imageView.isHidden = false
            numberLabel.isHidden = true
        } else {
            //just in case the image mode fails it falls back to numbers
            backgroundColor = .systemGray5
            imageView.isHidden = true
            numberLabel.isHidden = false
            numberLabel.text = "\(value)"
            numberLabel.font = UIFont.systemFont(ofSize: fontSize(), weight: .bold)
        }
    }

    // MARK: - Layout
    // fontSize() calculates based on the tile's actual size so it works for
    // all three grid sizes without any manual adjustment
    private func fontSize() -> CGFloat {
        return max(12, min(bounds.width, bounds.height) * 0.38)
    }

    // layoutSubviews is called by UIKit whenever the tile's frame changes,
    // so the font stays the right size if the board is resized
    override func layoutSubviews() {
        super.layoutSubviews()
        numberLabel.font = UIFont.systemFont(ofSize: fontSize(), weight: .bold)
    }
}
