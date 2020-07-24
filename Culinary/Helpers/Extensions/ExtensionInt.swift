//
//  ExtensionInt.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

extension Int {
    func product() -> String {
        var productString: String = ""
        if "1".contains("\(self % 10)")      {productString = "товар"}
        if "234".contains("\(self % 10)")    {productString = "товара" }
        if "567890".contains("\(self % 10)") {productString = "товаров"}
        if 11...14 ~= self % 100             {productString = "товаров"}
        return "\(self) " + productString
    }
    
    
    func portions() -> String {
        var portionsString = ""
        if "1".contains("\(self % 10)")      {portionsString = "порция"}
        if "234".contains("\(self % 10)")    {portionsString = "порции" }
        if "567890".contains("\(self % 10)") {portionsString = "порций"}
        if 11...14 ~= self % 100             {portionsString = "порций"}
        return "\(self) " + portionsString
    }
    
    func days() -> String{
        var daysString = ""
        if "1".contains("\(self % 10)")      {daysString = "день"}
        if "234".contains("\(self % 10)")    {daysString = "дня" }
        if "567890".contains("\(self % 10)") {daysString = "дней"}
        if 11...14 ~= self % 100             {daysString = "дней"}
        return "\(self) " + daysString
    }
    
    func hours() -> String{
        var hoursString = ""
        if "1".contains("\(self % 10)")      {hoursString = "час"}
        if "234".contains("\(self % 10)")    {hoursString = "часа" }
        if "567890".contains("\(self % 10)") {hoursString = "часов"}
        if 11...14 ~= self % 100             {hoursString = "часов"}
        return "\(self) " + hoursString
    }
    
    func minutes() -> String{
        var minutesString = ""
        if "1".contains("\(self % 10)")      {minutesString = "минута"}
        if "234".contains("\(self % 10)")    {minutesString = "минуты" }
        if "567890".contains("\(self % 10)") {minutesString = "минут"}
        if 11...14 ~= self % 100             {minutesString = "минут"}
        return "\(self) " + minutesString
    }
}
