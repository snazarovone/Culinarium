//
//  ContactsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContactsViewModel{
    private var dataContacts: BehaviorRelay<ContactsModel?> = BehaviorRelay(value: nil)
    
    init(contactsModel: BehaviorRelay<ContactsModel?>){
        self.dataContacts = contactsModel
    }
    
    func contacts() -> BehaviorRelay<ContactsModel?>{
        return self.dataContacts
    }
    
    var contactNumber: String?{
        return dataContacts.value?.data?.call_center_number
    }
    
    var workTime: String?{
        if let days = dataContacts.value?.data?.working_days{
            if let open = dataContacts.value?.data?.working_hours{
                return "\(days)\n\(open)"
            }else{
                return "\(days)"
            }
        }else{
            if let open = dataContacts.value?.data?.working_hours{
                return "\(open)"
            }
            return nil
        }
    }
}

extension ContactsViewModel: ContactsViewModelType{
    func numberOfRow() -> Int {
        return dataContacts.value?.data?.contacts?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> ContactCellViewModelType {
        let contact = dataContacts.value!.data!.contacts![indexPath.row]
        return ContactCellViewModel(contact: contact)
    }
    
   
}
