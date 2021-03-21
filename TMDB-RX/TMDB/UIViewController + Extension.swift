//
//  UIViewController + Extension.swift
//  TMDB
//
//  Created by Dina Reda on 3/20/21.
//


import Foundation
import UIKit
import MBProgressHUD
import CleanyModal

extension UIViewController {
    func showIndicator(withTitle title: String, and description: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    func showAlertWithImage(withTitle: String, andMessage message: String, andImage image: String, completion: (() -> Void)? = nil) {

        let alert = MyAlertViewController( title: withTitle, message: message,
            imageName: image)

        let okButton = CleanyAlertAction(title:"OK", style: .default) { (_) in
                    (completion ?? {})()
        }
        alert.addAction(okButton)

        present(alert, animated: true, completion: nil)
    }
}