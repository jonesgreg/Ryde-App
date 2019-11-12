//
//  extensions.swift
//  riderapp
//
//  Created by Gregory Jones on 7/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func hideSeparator() {
           self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
       }
       
       func showSeparator() {
           self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        return sizeThatFits
    }
}

extension UIView {
    
    func anchorPadding(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

   
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

extension UIButton {
    func setInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.titleEdgeInsets =  UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
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

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
           let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
           UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
           color.setFill()
           UIRectFill(rect)
           let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
           return image
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
extension UITableView {

func deselectSelectedRow(animated: Bool)
{
    if let indexPathForSelectedRow = self.indexPathForSelectedRow
    {
        self.deselectRow(at: indexPathForSelectedRow, animated: animated)
    }
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
        self.font = UIFont(name: Fonts.gilroySemiBold, size: 42)
       
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


////////////////////////////////////////////////////////////////////////////////////////////////////////

// Class Methods

////////////////////////////////////////////////////////////////////////////////////////////////////////




class verifyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.tintColor = Colors.fleetGreen
        self.font = UIFont(name: Fonts.gilroyMedium, size: 20)
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
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.3
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

class SafetyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = Colors.evernoteGreenColor
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.width(constant: 40)
        self.height(constant: 40)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class profileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.width(constant: 50)
        self.height(constant: 50)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HandlerAreaDesign: UIView {
    override init(frame: CGRect) {
          super.init(frame: frame)
          self.translatesAutoresizingMaskIntoConstraints = false
          self.backgroundColor = Colors.lightGreyColor
          self.layer.masksToBounds = false
          self.layer.cornerRadius = 2
          self.height(constant: 4)
        }
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
}



class greenCircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.backgroundColor = Colors.fleetGreen
        self.layer.cornerRadius = 16
        self.width(constant: 32)
        self.height(constant: 32)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class searchInputField: UITextField {
    override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.borderStyle = .none
    self.textColor = UIColor.black
    self.textAlignment = .center
    self.tintColor = Colors.fleetGreen
    self.font = UIFont(name: Fonts.gilroyMedium, size: 14)
    self.autocapitalizationType = UITextAutocapitalizationType.none
    self.autocorrectionType = .no
    self.returnKeyType = UIReturnKeyType.done
       
    }
    required init?(coder aDecoder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
  }
           
    
}


class DriverPickBottomButtons: UIView {
    weak var delegate: dismissDriverPickUpView?
    var DriverContactNumber = "443-768-9947"
    
    var backButton: UIButton = {
     let v = UIButton()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.imageView?.contentMode = .scaleAspectFit
    v.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return v
    }()
    
    
    var backButtonText: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: Fonts.gilroyRegular, size: 12)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    var callButton: UIButton = {
        let v = UIButton()
       v.translatesAutoresizingMaskIntoConstraints = false
       v.imageView?.contentMode = .scaleAspectFit
        v.addTarget( self, action: #selector(callDriver), for: .touchUpInside)
    
       return v
       }()
       
       
       var callButtonText: UIButton = {
          let button = UIButton()
             button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: Fonts.gilroyRegular, size: 12)
            button.setTitleColor(.black, for: .normal)
                  return button
      
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    convenience init(withImageName imageName: String, labelText: String) {

        self.init()
        self.commonInit()
        backButton.setImage(UIImage(named: imageName), for: .normal)
        callButton.setImage(UIImage(named: imageName), for: .normal)
        backButtonText.setTitle(labelText, for: .normal)
        callButtonText.setTitle(labelText, for: .normal)
     
       
    }
   
    
    
    func commonInit() -> Void {
    self.translatesAutoresizingMaskIntoConstraints = false

    addSubview(backButton)
    addSubview(backButtonText)
    addSubview(callButton)
    addSubview(callButtonText)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
        

            callButton.topAnchor.constraint(equalTo: topAnchor),
                  callButton.widthAnchor.constraint(equalToConstant: 20),
           callButton.heightAnchor.constraint(equalToConstant: 20),
       
           callButtonText.centerXAnchor.constraint(equalTo: callButton.centerXAnchor),
                       callButtonText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
                      callButtonText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 45),
                      
          backButtonText.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
           backButtonText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
          backButtonText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 45),
                           
         
                    
          ])
        
    }
    
    // Handle Selectors
   
      
      @objc func handleDismiss() {
          delegate?.handleDismissDriverPickUp()
      }
   
    @objc func callDriver() {
        if let phoneCallURL = URL(string: "telprompt://\(DriverContactNumber)") {

                             let application:UIApplication = UIApplication.shared
                             if (application.canOpenURL(phoneCallURL)) {
                                 if #available(iOS 10.0, *) {
                                     application.open(phoneCallURL, options: [:], completionHandler: nil)
                                 } else {
                                     // Fallback on earlier versions
                                      application.openURL(phoneCallURL as URL)

                                 }
                             }
                         }
                  }
    
}

class userInputField: UITextField  {
    
    fileprivate let cancelButtonLength: CGFloat = 15
    fileprivate let padding: CGFloat = 8
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.tintColor = Colors.fleetGreen
        self.font = UIFont(name: Fonts.gilroyMedium, size: 16)
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = .no
        self.returnKeyType = UIReturnKeyType.done
       // self.clearButtonMode = .whileEditing
       self.customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    @objc func clearClicked(sender: UIButton) {
            text = ""
          
          }
    override func rightViewRect( forBounds bounds: CGRect ) -> CGRect
      {
          let x = bounds.size.width - self.cancelButtonLength - self.padding
          let y = ( bounds.size.height - self.cancelButtonLength ) / 2
          let rightBounds = CGRect( x: x, y: y, width: self.cancelButtonLength, height: self.cancelButtonLength )
          return rightBounds
      }
    
    fileprivate func customLayout() {
               // Set custom clear button on right side
               let clearButton = UIButton()
               clearButton.setImage( UIImage( named: "clear_button" ), for: .normal )
               clearButton.contentMode = .scaleAspectFit
               clearButton.addTarget( self, action: #selector( self.clearClicked ), for: .touchUpInside )
               self.rightView = clearButton
              self.clearButtonMode = .whileEditing
              self.rightViewMode = .whileEditing
               
           }
}

class currentLocationSearch: UITextField {
    private let reuseIdentifer = "LocationCell"
       
      
       
       var resultsList: [Location] = [Location]()
       var tableView: UITableView!
       
       // Connecting the new element to the parent view
       open override func willMove(toWindow newWindow: UIWindow?) {
           super.willMove(toWindow: newWindow)
           tableView?.removeFromSuperview()
           
       }
       
       override open func willMove(toSuperview newSuperview: UIView?) {
           super.willMove(toSuperview: newSuperview)
           
           self.addTarget(self, action: #selector(searchLocation.textFieldDidChange), for: .editingChanged)
           self.addTarget(self, action: #selector(searchLocation.textFieldDidBeginEditing), for: .editingDidBegin)
           self.addTarget(self, action: #selector(searchLocation.textFieldDidEndEditing), for: .editingDidEnd)
           self.addTarget(self, action: #selector(searchLocation.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
       }
       override open func layoutSubviews() {
            super.layoutSubviews()
               configureTableView()
            
        }
       
       //////////////////////////////////////////////////////////////////////////////
         // Text Field related methods
         //////////////////////////////////////////////////////////////////////////////
         
         @objc open func textFieldDidChange(){
             print("Text changed ...")
            // filter()
             updateSearchTableView()
         
            // tableViewConstraints()
             tableView?.isHidden = false
         }
         
         @objc open func textFieldDidBeginEditing() {
             print("Begin Editing")
         }
         
         @objc open func textFieldDidEndEditing() {
             print("End editing")

         }
         
         @objc open func textFieldDidEndEditingOnExit() {
             print("End on Exit")
         }
       
       
       override init(frame: CGRect) {
         super.init(frame: frame)
         self.translatesAutoresizingMaskIntoConstraints = false
         self.borderStyle = .none
         self.textColor = UIColor.black
         self.textAlignment = .center
         self.tintColor = Colors.blueColor
         self.font = UIFont(name: Fonts.gilroyMedium, size: 16)
         self.autocapitalizationType = UITextAutocapitalizationType.none
         self.autocorrectionType = .no
         self.returnKeyType = UIReturnKeyType.done
            
         }
         required init?(coder aDecoder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
       }
     
    
}

class searchLocation: UITextField {
 private let reuseIdentifer = "LocationCell"
    var resultsList: [Location] = [Location]()
    var tableView: UITableView!
    
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
        
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(searchLocation.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(searchLocation.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(searchLocation.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(searchLocation.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    override open func layoutSubviews() {
         super.layoutSubviews()
            configureTableView()
         
     }
    
    //////////////////////////////////////////////////////////////////////////////
      // Text Field related methods
      //////////////////////////////////////////////////////////////////////////////
      
      @objc open func textFieldDidChange(){
          print("Text changed ...")
         // filter()
          updateSearchTableView()
      
         // tableViewConstraints()
          tableView?.isHidden = false
      }
      
      @objc open func textFieldDidBeginEditing() {
          print("Begin Editing")
      }
      
      @objc open func textFieldDidEndEditing() {
          print("End editing")

      }
      
      @objc open func textFieldDidEndEditingOnExit() {
          print("End on Exit")
      }
    
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.translatesAutoresizingMaskIntoConstraints = false
      self.borderStyle = .none
      self.textColor = UIColor.black
      self.textAlignment = .center
      self.tintColor = Colors.fleetGreen
      self.font = UIFont(name: Fonts.gilroyMedium, size: 16)
      self.autocapitalizationType = UITextAutocapitalizationType.none
      self.autocorrectionType = .no
      self.returnKeyType = UIReturnKeyType.done
         
      }
      required init?(coder aDecoder: NSCoder) {
                 fatalError("init(coder:) has not been implemented")
    }
  
      
     
}
extension UIView {
    
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
      DispatchQueue.main.async {
        UIView.animate(withDuration: duration) {
          self.alpha = alpha
        }
      }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.3) {
       fadeTo(1.0, duration: duration)
     }

     func fadeOut(_ duration: TimeInterval = 0.3) {
       fadeTo(0.0, duration: duration)
     }
}
extension searchLocation: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: TableView creation and updating
    
    func configureTableView() {
        if let tableView = tableView  {
               tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifer)
               tableView.delegate = self
               tableView.dataSource = self
              
               tableView.translatesAutoresizingMaskIntoConstraints = false
                self.window?.addSubview(tableView)
        } else {
            print("Table view is created")
            tableView = UITableView(frame: CGRect.zero)
            
        }
        
        updateSearchTableView()
    }
       func tableViewConstraints() {
           addSubview(tableView)
           tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
           tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
           tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
           tableView.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
       }
    
    // Updating table view
    func updateSearchTableView() {
       if let tableView = tableView {
                   superview?.bringSubviewToFront(tableView)
                   var tableHeight: CGFloat = 0
                   tableHeight = tableView.contentSize.height
                   
                   // Set a bottom margin of 10p
                   if tableHeight < tableView.contentSize.height {
                       tableHeight -= 10
                   }
                   
                   // Set tableView frame
                   var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
                   tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
                   tableViewFrame.origin.x += 2
                   tableViewFrame.origin.y += frame.size.height + 2
                   UIView.animate(withDuration: 0.2, animations: { [weak self] in
                       self?.tableView?.frame = tableViewFrame
                   })
                   
                   //Setting tableView style
                   tableView.layer.masksToBounds = true
                   tableView.separatorInset = UIEdgeInsets.zero
                   tableView.layer.cornerRadius = 5.0
                   tableView.separatorColor = UIColor.lightGray
                   tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                   
                   if self.isFirstResponder {
                       superview?.bringSubviewToFront(self)
                   }
                   
                   tableView.reloadData()
               }
    }
    
    // MARK: TableViewDataSourcce methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(resultsList.count)
        return resultsList.count
       }
       
    
    // MARK: TableViewDelegate methods
       
    //Adding rows in the tableview with the data from location
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! LocationCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.attributedText = resultsList[indexPath.row].getFormatedText()
        return cell
       }
}

extension currentLocationSearch: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: TableView creation and updating
    
    func configureTableView() {
        if let tableView = tableView  {
               tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifer)
               tableView.delegate = self
               tableView.dataSource = self
              
               tableView.translatesAutoresizingMaskIntoConstraints = false
                self.window?.addSubview(tableView)
        } else {
            print("Table view is created")
            tableView = UITableView(frame: CGRect.zero)
            
        }
        
        updateSearchTableView()
    }
       func tableViewConstraints() {
           addSubview(tableView)
           tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
           tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
           tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
           tableView.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
       }
    
    // Updating table view
    func updateSearchTableView() {
       if let tableView = tableView {
                   superview?.bringSubviewToFront(tableView)
                   var tableHeight: CGFloat = 0
                   tableHeight = tableView.contentSize.height
                   
                   // Set a bottom margin of 10p
                   if tableHeight < tableView.contentSize.height {
                       tableHeight -= 10
                   }
                   
                   // Set tableView frame
                   var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
                   tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
                   tableViewFrame.origin.x += 2
                   tableViewFrame.origin.y += frame.size.height + 2
                   UIView.animate(withDuration: 0.2, animations: { [weak self] in
                       self?.tableView?.frame = tableViewFrame
                   })
                   
                   //Setting tableView style
                   tableView.layer.masksToBounds = true
                   tableView.separatorInset = UIEdgeInsets.zero
                   tableView.layer.cornerRadius = 5.0
                   tableView.separatorColor = UIColor.lightGray
                   tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                   
                   if self.isFirstResponder {
                       superview?.bringSubviewToFront(self)
                   }
                   
                   tableView.reloadData()
               }
    }
    
    // MARK: TableViewDataSourcce methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(resultsList.count)
        return resultsList.count
       }
       
    
    // MARK: TableViewDelegate methods
       
    //Adding rows in the tableview with the data from location
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! LocationCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.attributedText = resultsList[indexPath.row].getFormatedText()
        return cell
       }
}

