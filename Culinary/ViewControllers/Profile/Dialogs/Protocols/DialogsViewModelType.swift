//
//  DialogsViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DialogsViewModelType {
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> DialogCellViewModelType
    func selectCell(at indexPath: IndexPath)
    func getIdUser() -> Int
    func getChatModel() -> BehaviorRelay<[Chat]>
}
