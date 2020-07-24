//
//  FilterViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class FilterViewModel: FilterViewModelType{
    
    private var fSections: [FiltersSection]?
    private var newFSection = [FiltersSection]()
    
    private var filterCafe: [FilterCafe]?
    private var newFilterCafe = [FilterCafe]()
    
    init(fSections: [FiltersSection]){
        self.fSections = fSections
        self.newFSection = fSections.clone()
    }
    
    init(filterCafe: [FilterCafe]){
        self.filterCafe = filterCafe
        self.newFilterCafe = filterCafe.clone()
    }
    
    func cellForRow(at indexPath: IndexPath) -> FilterCellViewModelType {
        if fSections != nil{
            return FilterCellViewModel(fItem: newFSection[indexPath.section].values![indexPath.row])
        }else{
            return FilterCellViewModel(filterCafeValue: newFilterCafe[indexPath.section].values![indexPath.row])
        }
    }
      
    func numberOfRow(in section: Int) -> Int {
        if fSections != nil{
            return newFSection[section].values?.count ?? 0
        }else{
            return newFilterCafe[section].values?.count ?? 0
        }
    }
    
    func numberSection() -> Int {
        if fSections != nil{
            return newFSection.count
        }else{
            return newFilterCafe.count
        }
    }
    
    func sectionCollapsed(at section: Int) -> Bool {
        if fSections != nil{
            return newFSection[section].collapsed
        }else{
            return newFilterCafe[section].collapsed
        }
    }
    
    func setCollapsed(at section: Int, collapsed: Bool){
        if fSections != nil{
            newFSection[section].collapsed = collapsed
        }else{
            newFilterCafe[section].collapsed = collapsed
        }
    }
    
    func headerName(at section: Int) -> String{
        if fSections != nil{
            return newFSection[section].title ?? ""
        }else{
            return newFilterCafe[section].title ?? ""
        }
    }
    
    func toogleField(at indexPath: IndexPath){
        if fSections != nil{
            newFSection[indexPath.section].values![indexPath.row].isSelect = !newFSection[indexPath.section].values![indexPath.row].isSelect
        }else{
            newFilterCafe[indexPath.section].values![indexPath.row].isSelect = !newFilterCafe[indexPath.section].values![indexPath.row].isSelect
        }
        
    }
    
    func applyNewFilters() {
        if let fSections = fSections{
            for (i, section) in fSections.enumerated(){
                for (j, item) in (section.values ?? []).enumerated(){
                    item.isSelect = newFSection[i].values![j].isSelect
                }
            }
        }else{
            if let filterCafe = filterCafe{
                for (i, section) in filterCafe.enumerated(){
                    for (j, item) in (section.values ?? []).enumerated(){
                        item.isSelect = newFilterCafe[i].values![j].isSelect
                    }
                }
            }
        }
    }
}
