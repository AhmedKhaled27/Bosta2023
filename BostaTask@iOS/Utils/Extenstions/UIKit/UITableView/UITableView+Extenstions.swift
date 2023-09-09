//
//  UITableView+Extenstions.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        let cellNib = UINib(nibName: "\(T.self)", bundle: nil)
        register(cellNib,
                 forCellReuseIdentifier: "\(T.self)")
    }
}
