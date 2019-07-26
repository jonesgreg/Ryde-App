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

class VerifyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Colors.lightGreyColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class codeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.textColor = UIColor.darkGray
        self.keyboardType = UIKeyboardType.numberPad
        self.autocorrectionType = .no
        self.textAlignment = .center
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


