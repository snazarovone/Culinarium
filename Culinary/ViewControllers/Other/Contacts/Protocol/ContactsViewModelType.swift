//
//  ContactsViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ContactsViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> ContactCellViewModelType
    func contacts() -> BehaviorRelay<ContactsModel?>
   
    var contactNumber: String? {get}
    var workTime: String? {get}
}
