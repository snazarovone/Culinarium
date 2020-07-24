//
//  MyOrdersViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MyOrdersViewModel: MyOrdersViewModelType{
    var orderTypes: OrderTypes = .current

    public let archivOrder: BehaviorRelay<[HistoryOrder]>
    public let currentOrder: BehaviorRelay<[HistoryOrder]>
    
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    init(archivOrder: BehaviorRelay<[HistoryOrder]>, currentOrder: BehaviorRelay<[HistoryOrder]>){
        
        self.archivOrder = archivOrder
        self.currentOrder = currentOrder
    }
    
    func numberOfRow() -> Int {
        switch orderTypes {
        case .current:
            return currentOrder.value.count
        case .history:
            return archivOrder.value.count
        }
    }
    
    func cellForRow(at indexPath: IndexPath) -> CurrentOrderCellViewModelType {
        return CurrentOrderCellViewModel(historyOrder: currentOrder.value[indexPath.row])
    }
    
    func cellForRowHist(at indexPath: IndexPath) -> HistOrderCellViewModelType {
        return HistOrderCellViewModel(ofRow: indexPath.row, historyOrder: archivOrder.value[indexPath.row])
    }
    
    //MARK:- Request DetailOrder
    func requestDetailOrder(at idOrder: Int, callback: @escaping (RequestComplite, HistoryDetail?)->()){
        HistoryAPI.requstHistoryBasket(type: HistoryDetailModel.self, request: .detailOrder(order_id: idOrder), delegate: delegate) { [weak self] (value, _) in
            if let detail = value{
                if let success = detail.success, success{
                    callback(.complite, detail.data)
                }else{
                    if let error = detail.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error, nil)
                }
            }else{
                callback(.error, nil)
            }
        }
    }
    
    //MARK:- Request Repeat Order
    func requestRepeatOrder(at id: Int, callback: @escaping (RequestComplite) -> ()){
        HistoryAPI.requstHistoryBasket(type: BaseResponseModel.self, request: .repeatOrder(order_id: id), delegate: delegate) { [weak self] (value, _) in
            if let value = value{
                if let success = value.success, success{
                    callback(.complite)
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }
            else{
                callback(.error)
            }
        }
    }
    
    //MARK:- Request Basket
    func requestBasket(basket: BehaviorRelay<BasketModel?> , callback: @escaping (RequestComplite) -> ()){
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .getBasket, delegate: delegate) { [weak self] (value, _) in
            if let basketModel = value{
                if let success = basketModel.success, success{
                    basket.accept(basketModel.data)
                    callback(.complite)
                }else{
                    if let error = basketModel.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }
            else{
                callback(.error)
            }
        }
    }
    
    func getAuth() -> ErrorAuth?{
        return self.auth
    }
    
}
