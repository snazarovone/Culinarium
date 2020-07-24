//
//  SplashViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashViewModelType{
    func getAuth() -> ErrorAuth?
    func getMenuSection() -> MenuSectionsModel?
    func getFavoritesDish() -> BehaviorRelay<MenuSectionsModel?>
    func getMyAddresses() -> BehaviorRelay<[AddressInfoUser]>
    func getUserInfo() -> BehaviorRelay<UserInfo?>
    func getNewsLetter() -> BehaviorRelay<NewsLetter>
    func getListCafe() -> BehaviorRelay<CafeModel?>
    func getDishesMainInfo() -> BehaviorRelay<[DishMainInfo]>
    func getChat() -> BehaviorRelay<[Chat]>
    func getBasket() -> BehaviorRelay<BasketModel?>
    func getCurrentOrders() -> BehaviorRelay<[HistoryOrder]>
    func getArchiveOrders() -> BehaviorRelay<[HistoryOrder]>
}
