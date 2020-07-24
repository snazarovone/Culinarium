//
//  UITabBarCulinary.swift
//  Culinary
//
//  Created by Sergey Nazarov on 02.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

@IBDesignable
class UITabBarCulinary: UITabBar {
    
    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.cgColor //рамка
        shapeLayer.fillColor = UIColor.white.cgColor //заливка
        shapeLayer.shadowColor = UIColor(red:0.157, green:0.165, blue:0.184, alpha:1.0).cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowColor = UIColor(red:0.157, green:0.165, blue:0.184, alpha:1.0).cgColor
        shapeLayer.shadowRadius = 8.0
        shapeLayer.shadowOpacity = 0.12
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override var traitCollection: UITraitCollection {
       guard UIDevice.current.userInterfaceIdiom == .pad else {
         return super.traitCollection
       }

       return UITraitCollection(horizontalSizeClass: .compact)
     }
    
    
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    func createPath() -> CGPath {
        
        let height: CGFloat = 24
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        // first curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: -height),
                      controlPoint1: CGPoint(x: (centerWidth - 28), y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 26, y: -height))
        // second curve up
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 26, y: -height),
                      controlPoint2: CGPoint(x: (centerWidth + 28), y: 0))
        
        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
}
