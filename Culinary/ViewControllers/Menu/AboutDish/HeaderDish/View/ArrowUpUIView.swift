//
//  ArrowUpUIView.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class ArrowUpUIView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var leftTop = 5.08
    var centerBottom = 7.13
    
  
    private var centerTop: Double{
        return centerBottom - 3.09
    }
    
    
    
    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let fillColor = UIColor(red: 0.157, green: 0.165, blue: 0.184, alpha: 1.000)

        //// Bezier Drawing
        context.saveGState()
        context.setAlpha(0.3)

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 30.01, y: 11.93))
        bezierPath.addCurve(to: CGPoint(x: 31.92, y: 11.01), controlPoint1: CGPoint(x: 30.79, y: 12.2), controlPoint2: CGPoint(x: 31.65, y: 11.79))
        bezierPath.addCurve(to: CGPoint(x: 30.99, y: 9.12), controlPoint1: CGPoint(x: 32.19, y: 10.23), controlPoint2: CGPoint(x: 31.77, y: 9.38))
        bezierPath.addLine(to: CGPoint(x: 16, y: centerTop))
        bezierPath.addCurve(to: CGPoint(x: 16, y: centerTop), controlPoint1: CGPoint(x: 16, y: centerTop), controlPoint2: CGPoint(x: 16.32, y: 3.96))
        bezierPath.addLine(to: CGPoint(x: 1.01, y: 9.12))
        bezierPath.addCurve(to: CGPoint(x: 0.08, y: 11.01), controlPoint1: CGPoint(x: 0.23, y: 9.38), controlPoint2: CGPoint(x: -0.19, y: 10.23))
        bezierPath.addCurve(to: CGPoint(x: 1.99, y: 11.93), controlPoint1: CGPoint(x: 0.35, y: 11.79), controlPoint2: CGPoint(x: 1.21, y: 12.2))
        bezierPath.addLine(to: CGPoint(x: 16, y: centerBottom))
        bezierPath.addLine(to: CGPoint(x: 30.01, y: 11.93))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()

        context.restoreGState()
    }
 

}
