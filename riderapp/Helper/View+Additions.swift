//
//  View+Additions.swift
//  riderapp
//
//  Created by Gregory Jones on 7/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    func addTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
