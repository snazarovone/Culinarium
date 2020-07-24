//
//  DialogsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DialogsViewModel: DialogsViewModelType{
    
    private var indexPath: IndexPath?
    private var chatModel: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    private let userInfo: UserInfo?
    
    init(chatModel: BehaviorRelay<[Chat]>, userInfo: UserInfo?){
        self.chatModel = chatModel
        self.userInfo = userInfo
    }
    
    func numberOfRow(in section: Int) -> Int {
        return chatModel.value.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> DialogCellViewModelType {
        return DialogCellViewModel(chat: chatModel.value[indexPath.row])
    }

    func selectCell(at indexPath: IndexPath){
        self.indexPath = indexPath
    }
    
    func getIdUser() -> Int{
        return userInfo?.id ?? -1
    }
    
    func getChatModel() -> BehaviorRelay<[Chat]>{
        return self.chatModel
    }
}
