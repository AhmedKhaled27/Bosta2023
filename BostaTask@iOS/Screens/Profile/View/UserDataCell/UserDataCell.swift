//
//  UserDataCell.swift
//  BostaTask@iOS
//
//  Created by Ahmed Khaled on 09/09/2023.
//

import UIKit

class UserDataCell: UITableViewCell {

    //MARK: OutLets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: Helper Functions
    private func setupUI() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        setupFonts()
        setupColors()
    }
    
    private func setupFonts() {
        userNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        userAddressLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    private func setupColors() {
        userNameLabel.textColor = .darkGray
        userAddressLabel.textColor = .black
    }

}

extension UserDataCell {
    func configureCell(userName: String,
                       userAddress: String) {
        userNameLabel.text = userName
        userAddressLabel.text = userAddress
    }
}
