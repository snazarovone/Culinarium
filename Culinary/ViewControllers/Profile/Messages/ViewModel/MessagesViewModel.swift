//
//  MessagesViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MessagesViewModel: MessagesViewModelType{
    
    private var chatModel: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    private var myID: Int
    private let indexPathChat: IndexPath
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    public var addImages = [UIImage?](arrayLiteral: nil, nil, nil)
    
    init(indexPath: IndexPath, chatModel: BehaviorRelay<[Chat]>, myID: Int){
        self.chatModel = chatModel
        self.myID = myID
        self.indexPathChat = indexPath
    }
    
    func numberOfRow(in section: Int) -> Int {
        return chatModel.value[indexPathChat.row].replies?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> MessageCellViewModelType {
        return MessageCellViewModel(chatReplie: chatModel.value[self.indexPathChat.row].replies![indexPath.row], myID: myID)
    }
    
    //MARK:- Request new message
    public func requestSendNewMessage(text: String?, callback: @escaping (RequestComplite, String?)->()){
       
        guard let idChat = chatModel.value[indexPathChat.row].id else{
            callback(.error, nil)
            return
        }
        let gallery = getImagesData()
        
        if let text = text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            
        }else{
            if gallery.count == 0{
                callback(.error, nil)
                return
            }
        }
        
        InfoUserAPI.requstObjectInfoUser(type: NewMessageModel.self, request: .sendMessage(chat_id: idChat, text: text!, images: gallery), delegate: delegate) {[weak self] (value) in
                         
            if let value = value{
                if let success = value.success, success{
                    if let self = self, let newMessage = value.data{
                        self.chatModel.value[self.indexPathChat.row].replies?.append(newMessage)
                        callback(.complite, nil)
                        return
                    }
                }
                else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                        callback(.error, nil)
                        return
                    }else{
                        if let error = value.error{
                            callback(.error, error)
                        }else{
                            callback(.error, "Ошибка отправки сообщения, пожалуйста повторите попытку")
                        }
                        return
                    }
                }
            }else{
                callback(.error, "Ошибка отправки сообщения, пожалуйста повторите попытку")
            }
        }
    }
    
    //MARK:- Request status is Read
    public func requestStatusIsRead(){
        guard let chatID = chatModel.value[indexPathChat.row].id, let replies = chatModel.value[indexPathChat.row].replies else {
            return
        }
    
        var statusIsRead : MessageStatus = .read
        
        for message in replies{
            if message.status == .unread{
                statusIsRead = .unread
                break
            }
        }
        
        allMessageChatIsRead()
        
        if statusIsRead == .unread{
            InfoUserAPI.requstObjectInfoUser(type: ResultFeedback.self, request: .statusIsRead(chat_id: chatID), delegate: delegate) { _ in
                return
            }
        }
    }
    
    private func allMessageChatIsRead(){
        for message in chatModel.value[indexPathChat.row].replies ?? []{
            message.status = .read
        }
        chatModel.accept(chatModel.value)
    }
    
    private func getImagesData() -> [Data]{
        var data = [Data]()
        for image in addImages{
            if let image = image{
                if let d = image.jpegData(compressionQuality: 0.6){
                    data.append(d)
                }
            }
        }
        return data
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
