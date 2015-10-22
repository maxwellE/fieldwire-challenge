//
//  FieldWireChallengeImageCollectionViewCell.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit
import SDWebImage

class FieldWireChallengeImageCollectionViewCell: UICollectionViewCell {
    weak var imageView : UIImageView?
    
    func setupImageCell(image: Image) {
        self.backgroundColor = UIColor.lightGrayColor()
        if let existingImageView = self.imageView {
            existingImageView.sd_setImageWithURL(NSURL(string: image.thumbnailURL()), placeholderImage: UIImage(), options: SDWebImageOptions.RetryFailed)
            return
        }
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        self.imageView = imageView
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        imageView.sd_setImageWithURL(NSURL(string: image.thumbnailURL()), placeholderImage: UIImage(), options: SDWebImageOptions.RetryFailed)
    }
    
    override func prepareForReuse() {
        self.imageView?.sd_cancelCurrentImageLoad()
        self.imageView?.image = nil
    }
}
