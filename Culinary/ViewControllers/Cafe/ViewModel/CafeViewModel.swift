//
//  CafeViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class CafeViewModel{
    
    public var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    private var filterListCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    public var cafeFilters = [FilterCafe]()
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    init(listCafe: BehaviorRelay<CafeModel?>){
        self.listCafe = listCafe
        self.cafeFilters = listCafe.value?.filters ?? []
        self.filterListCafe.accept(listCafe.value)
    }
    
    func getFilterListCafe() -> BehaviorRelay<CafeModel?>{
        return filterListCafe
    }
    
    func isOpenCafe(timeOpen: String, timeClosed: String, index: Int) -> UIImage{
        let date = Date()
        let dateCurrent = date.timeIntervalSince1970
        
        let sTO = timeOpen.split(separator: ":")
        if sTO.count == 3{
            let sTO_hour = Int(sTO[0])
            let sTO_Min = Int(sTO[1])
            let sTO_Sec = Int(sTO[2])
            
            let dateOpen = Calendar.current.date(bySettingHour: sTO_hour ?? 0, minute: sTO_Min ?? 0, second: sTO_Sec ?? 0, of: Date())
            
            if let dateOpen = dateOpen{
                let uTimeOpen = dateOpen.timeIntervalSince1970
                
                let sTC = timeClosed.split(separator: ":")
                if sTO.count == 3{
                    let sTC_Hour = Int(sTC[0])
                    let sTC_Min = Int(sTC[1])
                    let sTC_Sec = Int(sTC[2])
                    
                    let dateClose = Calendar.current.date(bySettingHour: sTC_Hour ?? 0, minute: sTC_Min ?? 0, second: sTC_Sec ?? 0, of: Date())
                    
                    if let dateClose = dateClose{
                        let uTimeClose = dateClose.timeIntervalSince1970
                        
                        if dateCurrent >= uTimeOpen && dateCurrent <= uTimeClose{
                            if indexPath.row == index{
                                return UIImage(named:"RedMarkerBig")!
                            }
                            return UIImage(named:"RedMarker")!
                        }
                    }
                }
            }
        }
        if indexPath.row == index{
            return UIImage(named:"grayMarkerBig")!
        }
        return UIImage(named:"grayMarker")!
    }
    
    //MARK:- Request Cafe by Filters
    public func requestCafeByFilters(lat: Double?, lon: Double?, callback: @escaping (RequestComplite)->()){
        guard let lat = lat, let lon = lon else{
            callback(.error)
            return
        }
        
        var typeIds = ""
        var inRadiusIds = ""
        var deliveryAreasIds = ""
        
        for filter in cafeFilters{
            if let typeFilter = filter.typeFilter{
                switch typeFilter {
                case .typeInstitution:
                    typeIds = getAllSelectedIdFilter(by: filter)
                case .inRadius:
                    inRadiusIds = getAllSelectedIdFilter(by: filter)
                case .deliveryAreas:
                    deliveryAreasIds = getAllSelectedIdFilter(by: filter)
                }
            }
        }
        
        CafeAPI.requstObjectCafe(type: CafeModel.self, request: .filterCafe(lat: "\(lat)", lng: "\(lon)", type: typeIds, delivery: deliveryAreasIds, radius: inRadiusIds), delegate: delegate) { [weak self] (value) in
            if let cafe = value{
                if let success = cafe.success, success{
                    self?.filterListCafe.accept(cafe)
                    callback(.complite)
                }else{
                    if let error = cafe.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
    }
    
    private func getAllSelectedIdFilter(by filter: FilterCafe) -> String{
        var ids: String = ""
        for value in filter.values ?? []{
            if value.isSelect, let id = value.id{
                ids += "\(id), "
            }
        }
        ids = ids.trimmingCharacters(in: .whitespacesAndNewlines)
        if ids.count > 0{
            ids = String(ids.dropLast())
        }
        
        return ids
    }
    
}

extension CafeViewModel: CafeViewModelType{
    func numberOfRow() -> Int {
        return filterListCafe.value?.cafes?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> CafeCellViewModelType {
        return CafeCellViewModel(cafe: filterListCafe.value!.cafes![indexPath.row])
    }
    
    func getIndexPath(at id: Int) -> IndexPath?{
        for (i, cafe) in (filterListCafe.value?.cafes ?? []).enumerated(){
            if cafe.id == id{
                self.indexPath = IndexPath(row: i, section: 0)
                return indexPath
            }
        }
        return nil
    }
    
    func didSelectCafe(indexPath: IndexPath) -> Cafe{
        return filterListCafe.value!.cafes![indexPath.row]
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
