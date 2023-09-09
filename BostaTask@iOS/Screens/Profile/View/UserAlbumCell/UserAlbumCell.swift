//
//  UserAlbumCell.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import UIKit

class UserAlbumCell: UITableViewCell {
    
    //MARK: OutLets
    @IBOutlet weak var label: UILabel!
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    //MARK: Helper Functions
    private func setupUI() {
        selectionStyle = .none
        setupFonts()
    }
    
    private func setupFonts() {
        label.font = UIFont.systemFont(ofSize: 15)
    }
}

extension UserAlbumCell {
    func configureCell(albumName: String) {
        self.label.text = albumName
    }
}
