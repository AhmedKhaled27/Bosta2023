//
//  UIViewController+Extensions.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showIndicator() {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertController(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            alert.addAction(okAction)
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true)
    }
}
