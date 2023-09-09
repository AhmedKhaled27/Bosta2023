//
//  UICollectionView+Extensions.swift
//  BostaTask@iOS
//
//  Created by Ahmed Khaled on 09/09/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(UINib(nibName: "\(T.self)",
                       bundle: nil),
                 forCellWithReuseIdentifier: "\(T.self)")
    }
}
