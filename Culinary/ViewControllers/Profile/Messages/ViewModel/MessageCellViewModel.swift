//
//  MessageCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class MessageCellViewModel: MessageCellViewModelType{
 
    var userPhoto: String?{
        return chatReplie.user?.image
    }
    
    var name: String{
        if myID == (chatReplie.user?.id ?? 0){
            return "Вы"
        }else{
            if let name = chatReplie.user?.name{
                if let surname = chatReplie.user?.surname{
                    return "\(name) \(surname)"
                }else{
                    return "\(name)"
                }
            }else{
                if let surname = chatReplie.user?.surname{
                    return "\(surname)"
                }else{
                    return ""
                }
            }
        }
    }
    
    var timeMessage: String?{
        //отображаем только время
        if let timeSplit = chatReplie.time?.split(separator: ":"){
            if timeSplit.count >= 2{
                return "\(timeSplit[0]):\(timeSplit[1])"
            }else{
                return ""
            }
        }
        return nil
    }
    
    var message: String?{
        return chatReplie.reply
    }
    
    var isHideFileView: Bool{
        if let images = chatReplie.images, images.count > 0{
            return false
        }
        return true
    }
    
    var images: [ImageDownloadViewModelType?]{
        var temImg = [ImageDownloadViewModelType?]()
        for img in chatReplie.images ?? []{
            temImg.append(ImageDownloadViewModel(chatImage: img))
        }
        return temImg
    }
    
    private let chatReplie: ChatReplie
    private let myID: Int
    
    init(chatReplie: ChatReplie, myID: Int){
        self.chatReplie = chatReplie
        self.myID = myID
    }
}
