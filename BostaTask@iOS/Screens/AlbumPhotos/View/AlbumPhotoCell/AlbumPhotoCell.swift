//
//  AlbumPhotoCell.swift
//  BostaTask@iOS
//
//  Created by Ahmed Khaled on 09/09/2023.
//

import UIKit

class AlbumPhotoCell: UICollectionViewCell {
    //MARK: OutLets
    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            imageView.kf.indicatorType = .activity
        }
    }
    
    //MARK: awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: Helper Functions
    func setImage(imageURL: URL) {
        imageView.kf.setImage(with: imageURL)
    }
}
