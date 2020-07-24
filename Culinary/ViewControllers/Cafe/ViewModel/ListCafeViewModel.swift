//
//  ListCafeViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListCafeViewModel{
    
    public var filterListCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    
    init(){
    }
    
    func getFilterListCafe() -> BehaviorRelay<CafeModel?>{
        return filterListCafe
    }
    
}
extension ListCafeViewModel: ListCafeViewModelType{
    func numberOfRow() -> Int {
        return filterListCafe.value?.cafes?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> ListCafeCellViewModelType {
        return ListCafeCellViewModel(cafe: filterListCafe.value!.cafes![indexPath.row])
    }
    
    func didSelectCafe(at indexPath: IndexPath) -> Cafe{
        return filterListCafe.value!.cafes![indexPath.row]
    }
}
