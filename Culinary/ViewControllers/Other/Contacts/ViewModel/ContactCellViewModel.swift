//
//  ContactCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class ContactCellViewModel: ContactCellViewModelType{
  
    var name: String{
        return contact.name ?? ""
    }
    
    var description: String?{
        return contact.description
    }
    
    var mail: String?{
        return contact.email
    }
    
    var phone: String?{
        return contact.phone
    }
    
    var isHiddenMail: Bool{
        if contact.email == nil{
            return true
        }
        return false
    }
    
    var isHiddenPhone: Bool{
        if contact.phone == nil{
            return true
        }
        return false
    }
    
    private let contact: ContactValue
 
    init(contact: ContactValue){
        self.contact = contact
    }
}
