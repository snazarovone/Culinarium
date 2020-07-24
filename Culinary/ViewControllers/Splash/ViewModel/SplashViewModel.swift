//
//  SplashViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit
import ObjectMapper

class SplashViewModel: SplashViewModelType, SplashViewDelegate{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate

    private var auth: ErrorAuth? = nil
    private var menuSection: MenuSectionsModel?
    private var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    private var myAddresses: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    private var userInfoData: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
    private var newsLetter: BehaviorRelay<NewsLetter> = BehaviorRelay(value: .notSubscribe)
    private var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    private var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    private var chatModel: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    private var basketModel: BehaviorRelay<BasketModel?> = BehaviorRelay(value: nil)
    private var archivOrder: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    private var currentOrders: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    private var stocks: BehaviorRelay<StocksModel?> = BehaviorRelay(value: nil)
 
    //Проверка авторизации
    //При значении false отправлям пользователя на форму регистрации
    //При значении true отправляем пользователя на главный экран
    func checkLogin() -> Bool{
        if let data = UserDefaults.standard.data(forKey: UDID.dataLogin.key),
            let saveData = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserAuth {
            UserAuth.shared = saveData
            self.auth = nil
            self.favoritesDish.accept(nil)
            return true
        }
        return false
    }
    
    //MARK:- Menu Section
    func requestListMeneSection(callback: @escaping (RequestComplite)->()){
        MenuAPI.requstObjectMenuSection(type: MenuSectionsModel.self, request: .getListSections, delegate: delegate) { [weak self] (value) in
            if let menuSection = value{
                if let success = menuSection.success, success{
                    self?.menuSection = menuSection
                    callback(.complite)
                }else{
                    if let error = menuSection.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
    }
    
    //MARK:- Favorite Dish
    func requestFavoriteDishes(callback: @escaping (RequestComplite)->()){
        WishlishAPI.requstObjectWishlist(type: MenuSectionsModel.self, request: .getWishlist, delegate: delegate) { [weak self] (value) in
            if let menuSection = value{
                if let success = menuSection.success, success{
                    self?.favoritesDish.accept(menuSection)
                    callback(.complite)
                }else{
                    if let error = menuSection.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
    }
    
    //MARK:- MyAddress
    func requestMyAddresses(){
        InfoUserAPI.requstObjectInfoUser(type: AddressInfoUserModel.self, request: .getAddressesDelivery, delegate: delegate) { [weak self] (value) in
            if let addresses = value{
                if let success = addresses.success, success{
                    if let data = addresses.data{
                        self?.myAddresses.accept(data)
                        return
                    }
                }
            }
            self?.myAddresses.accept([])
        }
    }
    
    //MARK:- UserInfo
    func requestUserInfo(){
        InfoUserAPI.requstObjectInfoUser(type: UserInfoModel.self, request: .getUserInfo, delegate: delegate) { [weak self] (value) in
            if let userInfo = value{
                if let success = userInfo.success, success{
                    if let data = userInfo.data{
                        self?.userInfoData.accept(data)
                        return
                    }
                }
            }
            self?.userInfoData.accept(nil)
        }
    }
    
    //MARK:- NewsLetter
    func requestNewsLetter(){
        InfoUserAPI.requstObjectInfoUser(type: NewsLetterModel.self, request: .getNewsletter, delegate: delegate) { [weak self] (value) in
            if let newsLetterData = value{
                if let success = newsLetterData.success, success{
                    self?.newsLetter.accept(newsLetterData.status)
                    return
                }
            }
            self?.newsLetter.accept(.notSubscribe)
        }
    }
    
    //MARK:- GetListCafe
    func requestListCafe(lat: String, lng: String){
        CafeAPI.requstObjectCafe(type: CafeModel.self, request: .listCafe(lat: lat, lng: lng), delegate: delegate) { [weak self] (value) in
            if let cafe = value{
                if let success = cafe.success, success{
                    self?.listCafe.accept(cafe)
                    return
                }
            }
            self?.listCafe.accept(nil)
        }
    }
    
    //MARK:- Get All Dishes
    func requestAllDishes(){
        MenuAPI.requstObjectMenuSection(type: AllDishesModel.self, request: .getAllDish, delegate: delegate) { [weak self] (value) in
            if let info = value{
                if let success = info.success, success{
                    self?.dishesMainInfo.accept(info.data ?? [])
                    return
                }
            }
            self?.dishesMainInfo.accept([])
        }
    }
    
    //MARK:- Get Chats
    func requestGetChats(){
        InfoUserAPI.requstObjectInfoUser(type: UserChatsModel.self, request: .userChats, delegate: delegate) { [weak self] (value) in
            if let chatModel = value{
                if let success = chatModel.success, success{
                    self?.chatModel.accept(chatModel.data ?? [])
                    return
                }
            }
            self?.chatModel.accept([])
        }
    }
    
    //MARK:- Get Basket
    func requestGetBasket(){
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .getBasket, delegate: delegate) { [weak self] (value, _) in
            if let basket = value{
                if let success = basket.success, success{
                    self?.basketModel.accept(basket.data)
                    return
                }
            }
            self?.basketModel.accept(nil)
        }
    }
    
    //MARK:- Request History Order
    func requestHistoryOrders(){
        HistoryAPI.requstHistoryBasket(type: HistoryOrderModel.self, request: .archive, delegate: delegate) { [weak self] (value, _) in
            if let archive = value{
                if let success = archive.success, success{
                    self?.archivOrder.accept(archive.data ?? [])
                }else{
                    self?.archivOrder.accept([])
                }
            }else{
                self?.archivOrder.accept([])
            }
        }
        
        HistoryAPI.requstHistoryBasket(type: HistoryOrderModel.self, request: .curentOrders, delegate: delegate) { [weak self] (value, _) in
            if let currentOrder = value{
                if let success = currentOrder.success, success{
                    self?.currentOrders.accept(currentOrder.data ?? [])
                }else{
                    self?.currentOrders.accept([])
                }
            }else{
                self?.currentOrders.accept([])
            }
        }
    }
    
    //MARK:- RequestStocks
    func requestListStocks(){
        StocksAPI.requestStocks(type: StocksModel.self, request: .allStocks, delegate: delegate) { [weak self] (value, _) in
            if let stocks = value{
                if let success = stocks.success, success{
                    self?.stocks.accept(stocks)
                }else{
                    self?.stocks.accept(nil)
                }
            }else{
                self?.stocks.accept(nil)
            }
        }
    }
    
    func updateDistance(myLocation: CLLocation){
        guard let cafes = listCafe.value else {
            return
        }
     
        for cafe in cafes.cafes ?? []{
            if let latStr = cafe.lat, let lngStr = cafe.lng{
                let lat = latStr.floatValue
                let lng = lngStr.floatValue
                
                let locCafe = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
                let distanceInMeters = locCafe.distance(from: myLocation)
                cafe.distance = Int(distanceInMeters)
            }
        }
        self.listCafe.accept(self.listCafe.value)
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
    
    func getMenuSection() -> MenuSectionsModel? {
        return self.menuSection
    }
    
    func getFavoritesDish() -> BehaviorRelay<MenuSectionsModel?> {
        return self.favoritesDish
    }
    
    func getMyAddresses() -> BehaviorRelay<[AddressInfoUser]> {
        return self.myAddresses
    }
    
    func getUserInfo() -> BehaviorRelay<UserInfo?> {
        return self.userInfoData
    }
    
    func getNewsLetter() -> BehaviorRelay<NewsLetter> {
        return self.newsLetter
    }
    
    func getListCafe() -> BehaviorRelay<CafeModel?> {
        return self.listCafe
    }
    
    func getDishesMainInfo() -> BehaviorRelay<[DishMainInfo]>{
        return self.dishesMainInfo
    }
    
    func getChat() -> BehaviorRelay<[Chat]>{
        return self.chatModel
    }
    
    func getBasket() -> BehaviorRelay<BasketModel?>{
        return self.basketModel
    }
    
    func getArchiveOrders() -> BehaviorRelay<[HistoryOrder]>{
        return self.archivOrder
    }
    
    func getCurrentOrders() -> BehaviorRelay<[HistoryOrder]>{
        return self.currentOrders
    }
    
    func getStocks() -> BehaviorRelay<StocksModel?>{
        return self.stocks
    }
}
