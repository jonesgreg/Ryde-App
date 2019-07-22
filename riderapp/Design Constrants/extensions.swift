//
//  extensions.swift
//  riderapp
//
//  Created by Gregory Jones on 7/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom:NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
        
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        
        if let bottom = bottom {
         
        bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        
        }
        
        
        if let leading = leading {
            
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            
        }
        
        if let trailing = trailing  {
         
        trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        
        }
       
       if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}

extension String  {
    func convertToInternationalFormat() -> String {
        let isMoreThanTenDigit = self.count > 10
        _ = self.startIndex
        var newstr = ""
        if isMoreThanTenDigit {
            newstr = "\(self.dropFirst(self.count - 10))"
        }
        else if self.count == 10{
            newstr = "\(self)"
        }
        else {
            return "number has only \(self.count) digits"
        }
        if  newstr.count == 10 {
            let internationalString = "(\(newstr.dropLast(7))) \(newstr.dropLast(4).dropFirst(3)) \(newstr.dropFirst(6).dropLast(2)) \(newstr.dropFirst(8))"
            newstr = internationalString
        }
        return newstr
    }
    
}
