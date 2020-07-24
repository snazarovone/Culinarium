//
//  OrgSlideCollectionViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgSlideCollectionViewModel: OrgSlideCollectionViewModelType{
    
    private var items = [Gallery]()
    private var currentPage: Int = 0
    
    init(items: [Gallery]){
        self.items = items
    }
    
    func numberOfRow(in section: Int) -> Int {
        return items.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> OrgSlideCollectionViewCellViewModelType {
        return OrgSlideCollectionViewCellViewModel(image: items[indexPath.row])
    }
    
    func changePage(at page: Int) {
        currentPage = page
    }
}
