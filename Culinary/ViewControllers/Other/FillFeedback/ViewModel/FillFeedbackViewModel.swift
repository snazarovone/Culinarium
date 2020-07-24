//
//  FillFeedbackViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FillFeedbackViewModel: FillFeedbackViewModelType{
    
    //PRIVATE
    private var dataFeedback = [FeedBackType]()
    private var selectIndexPath =  IndexPath(row: 0, section: 0)
    private var selectHeader: FillFeedbackHeader
    
    private var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    private var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    private var imagesGallery = [UIImage?]()
    
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
   
    
    //PUBLIC
    public var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: UserInfo())
    public var idSelectCafe: Int?
    public var idSelectDish: Int?
    
    
    init(selectHeader: FillFeedbackHeader?, listCafe: BehaviorRelay<CafeModel?>, idSelectCafe: Int?, idSelectDish: Int?, userInfo: BehaviorRelay<UserInfo?>, dishesMainInfo: BehaviorRelay<[DishMainInfo]>){
        let delivery = FeedBackType(name: FillFeedbackHeader.aboutDelivery.title, titleName: FillFeedbackHeader.aboutDelivery.titleNameVC, segueID: nil)
        let cafe = FeedBackType(name: FillFeedbackHeader.aboutCafe.title, titleName: FillFeedbackHeader.aboutCafe.titleNameVC, segueID: SegueID.cafePlaces.id)
        let dish = FeedBackType(name: FillFeedbackHeader.aboutDish.title, titleName: FillFeedbackHeader.aboutDish.titleNameVC, segueID: SegueID.dishFeed.id)
        let other = FeedBackType(name: FillFeedbackHeader.aboutOther.title, titleName: FillFeedbackHeader.aboutOther.titleNameVC, segueID: nil)
        dataFeedback = [delivery, cafe, dish, other]
        
        if let selectHeader = selectHeader{
            self.selectIndexPath = IndexPath(row: selectHeader.indexRow, section: 0)
            self.selectHeader = selectHeader
        }else{
            self.selectHeader = .aboutDelivery
        }
        
        self.listCafe = listCafe
        self.dishesMainInfo = dishesMainInfo
        self.idSelectCafe = idSelectCafe
        self.idSelectDish = idSelectDish
        self.userInfo = userInfo
        self.imagesGallery.append(nil)
    }
    
    func updateGalery(image: UIImage?){
        self.imagesGallery.insert(image, at: imagesGallery.count - 1)
    }
    
    func getImages() -> [Data]{
        var data = [Data]()
        for image in imagesGallery{
            if let image = image{
                if let d = image.jpegData(compressionQuality: 0.6){
                    data.append(d)
                }
            }
        }
        return data
    }
    
    func removeImage(at indexPath: IndexPath){
        self.imagesGallery.remove(at: indexPath.row)
    }
    
    func numberOfRow(in section: Int) -> Int {
        return dataFeedback.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType {
        var isSelect = false
        if selectIndexPath.row == indexPath.row{
            isSelect = true
        }
        return  BMenuCollectionCellViewModel(item: dataFeedback[indexPath.row].name, isSelect: isSelect, indexPath: indexPath, basketCellType: BasketCellType.menuItems)
    }
    
    func didSelect(at indexPath: IndexPath) {
        self.selectIndexPath = indexPath
        for field in FillFeedbackHeader.allCases{
            if field.indexRow == indexPath.row{
                selectHeader = field
                return
            }
        }
    }
    
    func requestSendFeedback(name: String, surname: String, phone: String, text: String, strengths: String, rating: Int, weaknesses: String, images: [Data], callback: @escaping (RequestComplite, String?)->()){
        
        switch selectHeader {
        case .aboutCafe:
            //MARK:- Request Cafe
        
            FeedbackAPI.requstObjectFeedback(type: ResultFeedback.self, request: .sendFeedbackCafe(cafe_id: idSelectCafe!, name: name, surname: surname, phone: phone, text: text, strengths: strengths, weaknesses: weaknesses, rating: rating, images: images), delegate: delegate) { [weak self] (value) in
                
                if let value = value{
                    if let success = value.success, success{
                        if let message = value.message{
                            callback(.complite, message)
                            return
                        }
                    }
                    else{
                        if let error = value.error, error == ErrorAuth.Unauthorized.value{
                            self?.auth = .Unauthorized
                            callback(.error, nil)
                            return
                        }else{
                            callback(.error, value.error)
                            return
                        }
                    }
                }else{
                    callback(.error, nil)
                }
            }
        case .aboutDish:
            //MARK:- Request Dish
            
            FeedbackAPI.requstObjectFeedback(type: ResultFeedback.self, request: .sendFeedbackDish(dish_id: idSelectDish!, name: name, surname: surname, phone: phone, text: text, strengths: strengths, weaknesses: weaknesses, rating: rating, images: images), delegate: delegate) { [weak self] (value) in
                
                if let value = value{
                    if let success = value.success, success{
                        if let message = value.message{
                            callback(.complite, message)
                            return
                        }
                    }
                    else{
                        if let error = value.error, error == ErrorAuth.Unauthorized.value{
                            self?.auth = .Unauthorized
                            callback(.error, nil)
                            return
                        }else{
                            callback(.error, value.error)
                            return
                        }
                    }
                }else{
                    callback(.error, nil)
                }
            }
        case .aboutDelivery:
            //MARK:- Request Delivery
            
            FeedbackAPI.requstObjectFeedback(type: ResultFeedback.self, request: .sendFeedbackDelivery(name: name, surname: surname, phone: phone, text: text, strengths: strengths, weaknesses: weaknesses, rating: rating, images: images), delegate: delegate) { [weak self] (value) in
                
                if let value = value{
                    if let success = value.success, success{
                        if let message = value.message{
                            callback(.complite, message)
                            return
                        }
                    }
                    else{
                        if let error = value.error, error == ErrorAuth.Unauthorized.value{
                            self?.auth = .Unauthorized
                            callback(.error, nil)
                            return
                        }else{
                            callback(.error, value.error)
                            return
                        }
                    }
                }else{
                    callback(.error, nil)
                }
            }
        case .aboutOther:
            //MARK:- Request Other:
            
            FeedbackAPI.requstObjectFeedback(type: ResultFeedback.self, request: .sendFeedbackOther(name: name, surname: surname, phone: phone, text: text, strengths: strengths, weaknesses: weaknesses, rating: rating, images: images), delegate: delegate) { [weak self] (value) in
                
                if let value = value{
                    if let success = value.success, success{
                        if let message = value.message{
                            callback(.complite, message)
                            return
                        }
                    }
                    else{
                        if let error = value.error, error == ErrorAuth.Unauthorized.value{
                            self?.auth = .Unauthorized
                            callback(.error, nil)
                            return
                        }else{
                            callback(.error, value.error)
                            return
                        }
                    }
                }else{
                    callback(.error, nil)
                }
            }
        }
        
    }
    
    
    func chekValidDataFeedback(name: String?, surname: String?, phone: String?, text: String?, strengths: String?, rating: Int?) -> (PersonalInfoField?, String?, Bool, Bool?){
  
        switch self.selectHeader {
        case .aboutCafe:
            guard idSelectCafe != nil else{
                return (nil, "Укажите кафе о котором хотите оставить отзыв", false, nil)
            }
        case .aboutDish:
            guard idSelectDish != nil else{
                return (nil, "Укажите блюдо о котором хотите оставить отзыв", false, nil)
            }
        default:
            break
        }
        
        
        guard name != nil, (name?.isEmpty ?? true) == false else{
            return (PersonalInfoField.name, nil, false, nil)
        }
        
        guard surname != nil, (surname?.isEmpty ?? true) == false else{
            return (PersonalInfoField.surname, nil, false, nil)
        }
        
        guard phone != nil, (phone?.count ?? 0) == 17  else{
            return (PersonalInfoField.phone, nil, false, nil)
        }
        
        guard text != nil, (text?.isEmpty ?? true) == false  else{
            return (nil, nil, false, true)
        }
        
        guard strengths != nil, (strengths?.isEmpty ?? true) == false  else{
            return (PersonalInfoField.advantages, nil, false, nil)
        }
            
        guard rating != nil, rating! > 0 else{
            switch selectHeader {
            case .aboutCafe:
                return (nil, "Укажите, Ваш, рейтинг кафе", false, nil)
            case .aboutDelivery:
                return (nil, "Укажите, Ваш, рейтинг доставки", false, nil)
            case .aboutDish:
                return (nil, "Укажите, Ваш, рейтинг блюда", false, nil)
            case .aboutOther:
                return (nil, "Укажите, Ваш, рейтинг", false, nil)
            }
        }
        
        //все поля валидны
        return (nil, nil, true, nil)
    }
    
    func getWightTextAt(indexPath: IndexPath) -> CGFloat {
        let font = UIFont(name:"Rubik-Medium", size:14.0)!
        var wight : CGFloat = 0.0
        
        let title = self.dataFeedback[indexPath.row].name
        wight = title.width(withConstrainedHeight: 16.5, font: font) + 32
        return wight
    }
    
    func getItemDataFeedback() -> FeedBackType{
        return dataFeedback[selectIndexPath.row]
    }
    
    func sernameUser() -> String?{
        return userInfo.value?.surname
    }
    
    func nameUser() -> String?{
        return userInfo.value?.name
    }
    
    func phoneUser() -> String?{
        return userInfo.value?.phone
    }
    
    public func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "X(XXX) XXX-XX-XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    public func nameSelectCafe() -> String?{
        guard let idSelectCafe = idSelectCafe, let listCafe = listCafe.value else{
            return ""
        }
        for cafe in listCafe.cafes ?? []{
            if let id = cafe.id, id == idSelectCafe{
                return cafe.title
            }
        }
        return ""
    }
    
    public func nameSelectDish() -> String?{
        guard let idSelectDish = idSelectDish else{
            return ""
        }
        
        for dish in dishesMainInfo.value{
            if let id = dish.id, id == idSelectDish{
                return dish.title
            }
        }
        return ""
    }
    
    public func getListCafe() -> BehaviorRelay<CafeModel?>{
        return self.listCafe
    }
    
    public func getListDish() -> BehaviorRelay<[DishMainInfo]>{
        return dishesMainInfo
    }
    
    
    //MARK:- Gallery
    func numberOfRowImages() -> Int {
        return self.imagesGallery.count
    }
    
    func cellForRowImage(at indexPath: IndexPath) -> AddingImageVIewModelType {
        return AddingImageVIewModel(image: self.imagesGallery[indexPath.row])
    }
    
    func didSelectImage(at indexPath: IndexPath) -> ImagesPicker{
        if self.imagesGallery[indexPath.row] == nil{
            return .add
        }else{
            return .remove
        }
    }
        
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
    
}

enum ImagesPicker {
    case add
    case remove
}
