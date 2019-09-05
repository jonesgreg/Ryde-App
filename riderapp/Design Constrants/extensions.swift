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
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }

   
}

extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
}

extension UIBarButtonItem {
    static func barButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.contentMode = .scaleAspectFit
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 23).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        return menuBarItem
    }
}

extension NSAttributedString {
    func replace(placeholder: String, with hyperlink: String, url: String) -> NSAttributedString {
        let mutableAttr = NSMutableAttributedString(attributedString: self)
        
        let hyperlinkAttr = NSAttributedString(string: hyperlink, attributes: [NSAttributedString.Key.link: URL(string: url)!])
        
        let placeholderRange = (self.string as NSString).range(of: placeholder)
        
        mutableAttr.replaceCharacters(in: placeholderRange, with: hyperlinkAttr)
        return mutableAttr
    }
}



extension NSAttributedString {
    
    static func createHyperLink(for path: String, in string: String, as substring: String)-> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        
        return attributedString
    }
    
}

class VerifyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
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
        self.textColor = UIColor.black
        self.keyboardType = UIKeyboardType.numberPad
        self.autocorrectionType = .no
        self.textAlignment = .center
        self.returnKeyType = UIReturnKeyType.done
        self.font = UIFont(name: Fonts.montserratSemiBold, size: 42)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class phoneNumberTextField: UITextField {
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.tintColor = Colors.fleetGreen
        self.borderStyle = .none
        self.keyboardType = UIKeyboardType.numberPad
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
       
    }
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class verifyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.tintColor = Colors.fleetGreen
        self.font = UIFont(name: Fonts.montserratMedium, size: 20)
        self.borderStyle = .none
        self.keyboardType = UIKeyboardType.numberPad
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class countryField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.borderStyle = .none
        self.isUserInteractionEnabled = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class greenButton: UIButton {
    override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.borderWidth = 1
    self.layer.borderColor = Colors.fleetGreen.cgColor
    self.backgroundColor = Colors.fleetGreen
    self.layer.masksToBounds = false
    self.layer.shadowColor = Colors.darkGreyColor.cgColor
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 2
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.cornerRadius = 25
        
    self.setTitleColor(.white, for: .normal)
    
  }
   required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
   }
}
class customView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 0
      
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowColor = Colors.darkGreyColor.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.cornerRadius = 25
       
        
        }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class NextButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = Colors.fleetGreen
        self.layer.cornerRadius = 32.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.width(constant: 65)
        self.height(constant: 65)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class whiteCircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.width(constant: 40)
        self.height(constant: 40)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class grayCircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
       
      //  self.layer.shadowRadius = 0.5
      //  self.layer.shadowOpacity = 0.3
      //  self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = Colors.fleetGreen
        self.layer.cornerRadius = 16
   //     self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.width(constant: 32)
        self.height(constant: 32)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class userInputField: UITextField  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.tintColor = Colors.fleetGreen
        self.font = UIFont(name: Fonts.montserratMedium, size: 20)
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



