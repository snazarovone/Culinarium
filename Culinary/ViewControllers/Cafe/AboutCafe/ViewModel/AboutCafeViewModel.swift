//
//  AboutCafeViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AboutCafeViewModel: AboutCafeViewModelType{
    
    private var cafeModel = [AboutCafeModels]()
    private var aboutCafe: Cafe?
    private var feedback = [FeedbackCafe]()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    private var isFeedbackGet = false
    
    init(aboutCafe: Cafe?){
        self.aboutCafe = aboutCafe
        getDataModel()
    }
    
    public func getDataModel(){
        guard let aboutCafe = aboutCafe else {
            return
        }
        
        let addressCafe = AddressCafeModel(working_days: aboutCafe.working_days, open: aboutCafe.open, close: aboutCafe.close, addressCafe: aboutCafe.address, metroName: aboutCafe.metro_station?.metro_line?.title, colorCircle: aboutCafe.metro_station?.metro_line?.color)
        
        
        var valueKitchens = ""
        for kit in aboutCafe.kitchens ?? []{
            valueKitchens = "\(valueKitchens) \(kit)"
        }
        valueKitchens = valueKitchens.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let info1 = InfoCafeModel(name: "Кухня", value: valueKitchens, isMake: nil)
        let info2 = InfoCafeModel(name: "Wi-Fi", value: nil, isMake: aboutCafe.isWifi)
        let info3 = InfoCafeModel(name: "Закуски", value: nil, isMake: aboutCafe.isSnacks)
        let info4 = InfoCafeModel(name: "Заказ еды", value: nil, isMake: aboutCafe.isFood_order)
        let info5 = InfoCafeModel(name: "Средний чек", value: "\(aboutCafe.average_check ?? 0) ₽", isMake: nil)
       
        let titleFeedback = TitleFeedbackCafe()
       
        cafeModel = [addressCafe, info1, info2, info3, info4, info5, titleFeedback]
        
        for feed in feedback{
            let cafeFeedbackModel = CafeFeedbackModel(feedbackCafe: feed)
            cafeModel.append(cafeFeedbackModel)
        }
    }
    
    //MARK:- Request Feedback
    func requestFeedbackAboutCafe(callback: @escaping (RequestComplite)->()){
        guard let id = aboutCafe?.id else{
            callback(.error)
            return
        }
        
        isFeedbackGet = true
        
            
        CafeAPI.requstObjectCafe(type: FeedbackCafeModel.self, request: .getFeedbackAboutCafe(cafe_id: id), delegate: delegate) { [weak self] (value) in
            if let feedbacks = value{
                if let success = feedbacks.success, success{
                    self?.feedback = feedbacks.data ?? []
                    callback(.complite)
                }else{
                    if let error = feedbacks.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
        
    }
    
    func numberOfRow() -> Int {
        return cafeModel.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AboutCafeModels {
        let dataModel = cafeModel[indexPath.row]
        switch dataModel.typeCell {
        case .addressCafe:
            return AddressCafeCellModel(addressCafeModel: dataModel as! AddressCafeModel)
        case .infoCafe:
            return InfoCafeCellViewModel(info: dataModel as! InfoCafeModel)
        case .titleFeedback:
            return dataModel
        case .feedback:
            return FeedbackCafeCellViewModel(feed: (dataModel as! CafeFeedbackModel).feedbackCafe)
        }
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
    
    func isGetFeedback() -> Bool {
        return isFeedbackGet
    }
    
    func getPhoneNumber() -> String?{
        return aboutCafe?.phone
    }
    
    func getLocation() -> CLLocationCoordinate2D?{
        if let latStr = aboutCafe?.lat, let lonStr = aboutCafe?.lng{
            if let lat = Float(latStr), let lon = Float(lonStr){
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
            }
        }
        
        return nil
    }
    
    func locationForYandexMap() -> (String, String)?{
        if let latStr = aboutCafe?.lat, let lonStr = aboutCafe?.lng{
            return (latStr, lonStr)
        }
        
        return nil
    }
    
    func getNameCafe() -> String{
        return aboutCafe?.title ?? ""
    }
    
    func getIdCafe() -> Int?{
        return aboutCafe?.id
    }
}
