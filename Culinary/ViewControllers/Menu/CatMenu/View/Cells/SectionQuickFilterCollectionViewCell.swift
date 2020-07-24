//
//  SectionQuickFilterCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class SectionQuickFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cashPaymentBtn: UIButtonDesignable!
    @IBOutlet weak var expressDeliveryBtn: UIButtonDesignable!
    @IBOutlet weak var discontBtn: UIButtonDesignable!
    
    weak var quickFiltersDelegate: QuickFiltersDelegate?
    
    private var cash: QuickFilters?
    private var express: QuickFilters?
    private var disc: QuickFilters?
    
    
    weak var dataSectionQuickFilter: SectionQuickFilterCellViewModelType?{
        willSet(data){
            if (data?.cash_payment.value ?? 0) == 1{
                cashPaymentBtn.backgroundColor = UIColor(named: "Orange_F4AD24") ?? .orange
                cash = .cash_payment
            }else{
                cashPaymentBtn.backgroundColor = UIColor(named: "Gray_D4D0CD") ?? .gray
                cash = .not_cash_payment
            }
            
            if (data?.express_delivery.value ?? 0) == 1{
                expressDeliveryBtn.backgroundColor = UIColor(named: "Orange_F4AD24") ?? .orange
                express = .express_delivery
            }else{
                expressDeliveryBtn.backgroundColor = UIColor(named: "Gray_D4D0CD") ?? .gray
                express = .not_express_delivery
            }
            
            if (data?.discount.value ?? 0) == 1{
                discontBtn.backgroundColor = UIColor(named: "Orange_F4AD24") ?? .orange
                disc = .discount
            }else{
                discontBtn.backgroundColor = UIColor(named: "Gray_D4D0CD") ?? .gray
                disc = .not_discount
            }
            
        }
    }
    
    @IBAction func cashPayment(_ sender: UIButtonDesignable) {
        if (cash ?? .not_cash_payment) == .cash_payment {
            quickFiltersDelegate?.quickFilter(filter: .not_cash_payment)
        }else{
            quickFiltersDelegate?.quickFilter(filter: .cash_payment)
        }
    }
    
    @IBAction func expressDelivery(_ sender: UIButtonDesignable) {
        if (express ?? .not_express_delivery) == .express_delivery {
            quickFiltersDelegate?.quickFilter(filter: .not_express_delivery)
        }else{
            quickFiltersDelegate?.quickFilter(filter: .express_delivery)
        }
    }
    
    @IBAction func discount(_ sender: UIButtonDesignable) {
        if (disc ?? .not_discount) == .discount {
            quickFiltersDelegate?.quickFilter(filter: .not_discount)
        }else{
            quickFiltersDelegate?.quickFilter(filter: .discount)
        }
    }
}
