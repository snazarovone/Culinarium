//
//  SearchViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class SearchViewModel: SearchViewModelType{
    var name: String
    
    init(searchEatModel: DisheModel){
        self.name = searchEatModel.title ?? ""
    }
}
