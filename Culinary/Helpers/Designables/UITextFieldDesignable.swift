//
//  UITextFieldDesignable.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

@IBDesignable class UITextFieldDesignable: UITextField {
    @IBInspectable var borderW: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderW
        }
    }
    
    @IBInspectable var borderC: UIColor = .clear {
        didSet{
            self.layer.borderColor = borderC.cgColor
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
