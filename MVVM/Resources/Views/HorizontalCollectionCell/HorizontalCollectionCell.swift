//
//  HorizontalCollectionCell.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/14/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation
import UIKit

class HorizontalCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    var withBackView : Bool! {
        didSet {
            self.backViewGenrator()
        }
    }
    private lazy var backView: UIImageView = {
        let backView = UIImageView(frame: image.frame)
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: image.topAnchor, constant: -10),
            backView.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: image.bottomAnchor)
            ])
        backView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        backView.alpha = 0.5
        contentView.bringSubviewToFront(image)
        return backView
    }()
    public var album: Album! {
        didSet {
            self.image.loadImage(fromURL: album.albumArtWork)
            self.subtitle.text = ""
            self.title.text = album.name
        }
    }
    private func backViewGenrator(){
        backView.loadImage(fromURL: album.albumArtWork)
    }
    override func prepareForReuse() {
        image.image = UIImage()
        backView.image = UIImage()
    }
}
