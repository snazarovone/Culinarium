//
//  OrganizeViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class OrganizeViewModel{
    
    private var dataOrganize = [OrganizeTableCellModelType]()

    
    init(){
        let menu = OrgMenuModel(items: [.banket, .holidayInCafe, .catering])
        let slideShow = OrgSlideShow(items: [#imageLiteral(resourceName: "org1"), #imageLiteral(resourceName: "org2"), #imageLiteral(resourceName: "org1"), #imageLiteral(resourceName: "org2"), #imageLiteral(resourceName: "org1"), #imageLiteral(resourceName: "org2")])
        dataOrganize = [menu, slideShow]
        
        for i in menu.items[menu.selectedItem.row].infoModel{
            dataOrganize.append(i)
        }
        
        let description = OrgDescriptionModel(text: menu.items[menu.selectedItem.row].infoDescription)
        dataOrganize.append(description)
    }
    
    //MARK:- Delegates
    //Menu
    func changeDataMenuDelegate(at currentIndex: IndexPath){
        for menuModel in dataOrganize{
            if menuModel.organizeTableCellType == .menu {
                (menuModel as! OrgMenuModel).selectedItem = currentIndex
                changeInfoModels()
                return
            }
        }
    }
    
    private func changeInfoModels(){
        var newData = dataOrganize.filter { (data) -> Bool in
            if data.organizeTableCellType != .info &&
                data.organizeTableCellType != .descriptionOrg{
                return true
            }else{
                return false
            }
        }
        
        for d in newData{
            if d.organizeTableCellType == .menu{
                let menu = d as! OrgMenuModel
                for i in menu.items[menu.selectedItem.row].infoModel{
                    newData.append(i)
                }
                let description = OrgDescriptionModel(text: menu.items[menu.selectedItem.row].infoDescription)
                newData.append(description)
                break
            }
        }
        dataOrganize = newData
    }
    
    //SlideShow
    func changeDataSlideShowDelegate(at page: Int){
        for data in dataOrganize{
            if data.organizeTableCellType == .slideShow{
                (data as! OrgSlideShow).currentPage = page
                return
            }
        }
    }
}

extension OrganizeViewModel: OrganizeViewModelType{
    func numberOfRow(in section: Int) -> Int {
        return dataOrganize.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> OrganizeTableCellModelType {
        let data = dataOrganize[indexPath.row]
        switch data.organizeTableCellType {
        case .menu:
            let model = data as! OrgMenuModel
            return OrgMenuTableCellViewModel(items: model.items, selectedItem: model.selectedItem)
        case .slideShow:
            return OrgSlideShowTableCellViewModel(items: (data as! OrgSlideShow).items)
        case .info:
            return OrgInfoCellViewModel(item: (data as! OrgInfoModel))
        case .descriptionOrg:
            return OrgDescriptionViewModel(text: (data as! OrgDescriptionModel).text)
        }
    }
    
}
