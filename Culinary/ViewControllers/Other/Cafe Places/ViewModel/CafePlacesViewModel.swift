//
//  CafePlacesViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CafePlacesViewModel: CafePlacesViewModelType{
    
    private var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    
    init(listCafe: BehaviorRelay<CafeModel?>){
        self.listCafe = listCafe
    }
    
    func numberOfRow() -> Int {
        return listCafe.value?.cafes?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> CafePlaceCellViewModelType {
        return CafePlaceCellViewModel(cafe: listCafe.value!.cafes![indexPath.row])
    }
    
    func didSelectRow(at indexPath: IndexPath) -> Int? {
        return listCafe.value?.cafes?[indexPath.row].id
    }
    
    func getListCafe() -> BehaviorRelay<CafeModel?>{
        return self.listCafe
    }
}
