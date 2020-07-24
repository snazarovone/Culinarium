//
//  ShareType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum ShareType {
    case stocks
    case coupons
    case seasonTicket
}

extension ShareType{
    var title: String{
        switch self{
        case .stocks:
            return "Поделиться акцией?"
        case .coupons:
            return "Поделиться купоном?"
        case .seasonTicket:
            return "Поделиться абонементом"
        }
    }
    
    var description: NSMutableAttributedString{
        switch self {
        case .coupons:
           let attributedStringParagraphStyle = NSMutableParagraphStyle()
           attributedStringParagraphStyle.alignment = NSTextAlignment.center
           attributedStringParagraphStyle.minimumLineHeight = 14.0

           let attributedString = NSMutableAttributedString(string: "Понравился купон? \nПоделитесь им со своими друзьями и получите 5 баллов на счет.")

           attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(0,63))
           attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Medium", size:13.0)!, range:NSMakeRange(63,8))
           attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(71,9))
           attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,80))
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(0,63))
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(63,8))
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(71,9))
            return attributedString
        case .stocks:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.alignment = NSTextAlignment.center
            attributedStringParagraphStyle.minimumLineHeight = 14.0

            let attributedString = NSMutableAttributedString(string: "Понравилась акция? \nПоделитесь ей со своими друзьями и получите 5 баллов на счет.")

            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(0,64))
            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Medium", size:13.0)!, range:NSMakeRange(64,8))
            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(72,9))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,81))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(0,64))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(64,8))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(72,9))
            return attributedString
        case .seasonTicket:
            let attributedStringParagraphStyle = NSMutableParagraphStyle()
            attributedStringParagraphStyle.alignment = NSTextAlignment.center
            attributedStringParagraphStyle.minimumLineHeight = 14.0

            let attributedString = NSMutableAttributedString(string: "Понравился абонемент? \nПоделитесь им со своими друзьями и получите 5 баллов на счет.")

            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(0,67))
            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Medium", size:13.0)!, range:NSMakeRange(67,8))
            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(75,9))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,84))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(0,67))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.751, green:0.129, blue:0.148, alpha:1.0), range:NSMakeRange(67,8))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0), range:NSMakeRange(75,9))
            return attributedString
        }
    }
}


