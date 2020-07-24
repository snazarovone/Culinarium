//
//  UILabelDesignable.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

@IBDesignable class UILabelDesignable: UILabel {
    
    @IBInspectable var lineHeight: CGFloat = 20 {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.alignment = self.textAlignment
            
            let attrString = NSMutableAttributedString(string: text!)
            attrString.addAttribute(NSAttributedString.Key.font, value: font ?? UIFont.systemFont(ofSize: 14.0), range: NSRange(location: 0, length: attrString.length))
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
            attributedText = attrString
        }
    }
    
    
      @IBInspectable var borderRadius: CGFloat = 0.0 {
          didSet{
              self.layer.cornerRadius = borderRadius
          }
      }
}
