//
//  MenuViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol MenuViewModelType{
    
    func nemberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> MenuCellViewModelType
    
    func searchNumberOfRow(in section: Int) -> Int
    func searchCellForRow(at indexPath: IndexPath) -> SearchViewModelType
    func sectionId(at indexPath: IndexPath) -> Int?
    
    func getAuth() -> ErrorAuth?
    func getSearchEatModel() -> [DisheModel]
    func getSearchEatModel(at indexPath: IndexPath) -> DisheModel
}
