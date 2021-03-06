//
//  UIButtonDesignable.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

@IBDesignable class UIButtonDesignable: UIButton {
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
    
    @IBInspectable var aligmentCenter: Bool = false{
        didSet{
            if aligmentCenter{
                self.titleLabel?.textAlignment = .center
            }else{
                self.titleLabel?.textAlignment = .natural
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else {
                   layer.shadowColor = nil
               }
           }
       }
       
       @IBInspectable var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
       @IBInspectable var shadowOffset: CGPoint {
           get {
               return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
           }
           set {
               layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
           }
           
       }
       
       @IBInspectable var shadowBlur: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue / 2.0
           }
       }
       
       @IBInspectable var shadowSpread: CGFloat = 0 {
           didSet {
               if shadowSpread == 0 {
                   layer.shadowPath = nil
               } else {
                   let dx = -shadowSpread
                   let rect = bounds.insetBy(dx: dx, dy: dx)
                   layer.shadowPath = UIBezierPath(rect: rect).cgPath
               }
           }
       }
}
