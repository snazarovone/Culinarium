//
//  AddressTF.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum AddressTF: CaseIterable{
    case name
    case city
    case street
    case numberHouse
    case numberFront
    case numberFlat
    case numberFloor
    case numberCode
}

extension AddressTF{
    var tag: Int{
        switch self {
        case .name:
            return 0
        case .city:
            return 1
        case .street:
            return 2
        case .numberHouse:
            return 3
        case .numberFront:
            return 4
        case .numberFloor:
            return 5
        case .numberFlat:
            return 6
        case .numberCode:
            return 7
        }
    }
    
    var hint: NSAttributedString{
        switch self {
        case .name:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSMutableAttributedString(string: "Придумайте название *")

            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:15.0)!, range:NSMakeRange(0,21))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,21))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5), range:NSMakeRange(0,20))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(20,1))
            return attributedString
        case .city:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSMutableAttributedString(string: "Город *")

            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:15.0)!, range:NSMakeRange(0,7))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,7))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5), range:NSMakeRange(0,6))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(6,1))
            return attributedString
        case .street:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSMutableAttributedString(string: "Улица *")

            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:15.0)!, range:NSMakeRange(0,7))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,7))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5), range:NSMakeRange(0,6))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(6,1))
            return attributedString
        case .numberHouse:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSAttributedString(string: "Дом", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5),NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            return attributedString
        case .numberFront:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSAttributedString(string: "Подъезд", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5),NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            return attributedString
        case .numberFloor:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSAttributedString(string: "Квартира", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5),NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            return attributedString
        case .numberFlat:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSAttributedString(string: "Этаж", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5),NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            return attributedString
        case .numberCode:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.minimumLineHeight = 14.0
            attributedStringParagraphStyle.paragraphSpacing = 1.0

            let attributedString = NSAttributedString(string: "Код двери", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:0.5),NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            return attributedString
        }
    }
}
