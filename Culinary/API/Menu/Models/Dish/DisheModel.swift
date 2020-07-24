//
//  DisheModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class DisheModel: Mappable{
    
    var id: Int?
    var title: String?
    var description: String?
    var consist: String?
    var preview_image: String?
    var gallery:[String]?
    var category_id: Int?
    var additional_info: String?
    var discount: Int?
    var portions: [PortionsDish]?
    
    private var wishlistMenu: Int?
    var wishlist: FavoriteDish = .unFavorite
    
    private var discountFilterMenu: Int?
    private var cash_paymentMenu: Int?
    private var express_deliveryMenu: Int?
    
    var discountFilter: QuickFilters = .not_discount
    var cash_payment: QuickFilters = .not_cash_payment
    var express_delivery: QuickFilters = .not_express_delivery
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        consist <- map["consist"]
        preview_image <- map["preview_image"]
        gallery <- map["gallery"]
        category_id <- map["category_id"]
        additional_info <- map["additional_info"]
        discount <- map["discount"]
        portions <- map["portions"]
        
        discountFilterMenu <- map["discount_filter"]
        cash_paymentMenu <- map["cash_payment"]
        express_deliveryMenu <- map["express_delivery"]
        wishlistMenu <- map["wishlist"]
        
        if let discountFilterMenu = discountFilterMenu, discountFilterMenu == 1{
            self.discountFilter = .discount
        }
        
        if let cash_paymentMenu = cash_paymentMenu, cash_paymentMenu == 1{
            self.cash_payment = .cash_payment
        }
        
        if let express_deliveryMenu = express_deliveryMenu, express_deliveryMenu == 1{
            self.express_delivery = .express_delivery
        }
        
        if let wishlistMenu = wishlistMenu, wishlistMenu == 1{
            wishlist = .favorite
        }else{
            wishlist = .unFavorite
        }
        
    }
    
    
}
