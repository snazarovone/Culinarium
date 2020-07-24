//
//  MessagesViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol MessagesViewModelType {
    
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> MessageCellViewModelType
    
    func getAuth() -> ErrorAuth?
}
