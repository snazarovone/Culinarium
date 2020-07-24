//
//  BasketViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BasketViewModelType {
    var titleChekoutBtn: String {get}
    
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> BasketModelType
    func remove(at indexPaht: IndexPath) -> Int?
    
    func changeDataMenuDelegate(currentIndex: Int)
}
