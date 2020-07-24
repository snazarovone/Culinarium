//
//  DialogCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class DialogCellViewModel: DialogCellViewModelType{
   
    var img: String?{
        return chat.image
    }
    
    var message: String?{
        return chat.replies?.first?.reply
    }
    
    var timeLastMessage: String?{
        return dateLastMessage()
    }
    
    var themeMessage: String?{
        return chat.theme
    }
    
    var timeBeginDialog: String?{
        return dateBeginChat()
    }
    
    var countNewMessage: String?{
        return "\(countMessage)"
    }
    
    var hideCountNewMessage: Bool?{
        if countMessage > 0{
            return false
        }else{
            return true
        }
    }
    
    private var chat: Chat
    private var countMessage: Int = 0
    
    init(chat: Chat){
        self.chat = chat
        
        for replie in chat.replies ?? []{
            if replie.status == .unread{
                countMessage += 1
            }
        }
    }
    
    private func dateBeginChat() -> String{
        if let date = chat.replies?.first?.date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            dateFormatter.timeZone = .current
            if let dateF = dateFormatter.date(from: date){
                dateFormatter.dateFormat = "dd.MM.yy"
                return "от \(dateFormatter.string(from: dateF))"
            }else{
                return "от \(date)"
            }
        }else{
            return ""
        }
    }
    
    private func dateLastMessage() -> String{
        if let date = chat.replies?.last?.date, let time = chat.replies?.last?.time{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
            if let dateF = dateFormatter.date(from: date){
                var calendar = Calendar.autoupdatingCurrent
                calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
                print("\(calendar.component(.year, from: Date())) - \(calendar.component(.month, from: Date())) - \(calendar.component(.day, from: Date()))")
                print(dateF)
                if calendar.isDateInToday(dateF){
                    //отображаем только время
                    let timeSplit = time.split(separator: ":")
                    if timeSplit.count >= 2{
                        return "\(timeSplit[0]):\(timeSplit[1])"
                    }else{
                        return ""
                    }
                }else{
                    if calendar.isDateInYesterday(dateF){
                        return "Вчера"
                    }else{
                        dateFormatter.dateFormat = "dd.MM.yy"
                        return dateFormatter.string(from: dateF)
                    }
                }
            }else{
                return date
            }
        }else{
            return ""
        }
    }
}
