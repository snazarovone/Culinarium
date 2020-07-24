//
//  MenuViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MenuViewModel: MenuViewModelType{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    private var menuModel = [MenuSection]()
    private var searchEatModel = [DisheModel]()
    private var auth: ErrorAuth? = nil
    
    init(){
        
    }
    
    init(menuSection: MenuSectionsModel){
        self.menuModel = menuSection.data ?? []
        self.searchEatModel = []
    }
    
    func getSearchEatModel() -> [DisheModel]{
        return self.searchEatModel
    }
    
    func getSearchEatModel(at indexPath: IndexPath) -> DisheModel{
        return self.searchEatModel[indexPath.row]
    }
    
    func nemberOfRow(in section: Int) -> Int {
        return menuModel.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> MenuCellViewModelType {
        return MenuCellViewModel(menuSection: menuModel[indexPath.row])
    }
    
    func searchNumberOfRow(in section: Int) -> Int {
        return searchEatModel.count
    }
    
    func searchCellForRow(at indexPath: IndexPath) -> SearchViewModelType {
        return SearchViewModel(searchEatModel: searchEatModel[indexPath.row])
    }
    
    func sectionId(at indexPath: IndexPath) -> Int? {
        return menuModel[indexPath.row].id
    }
    
    //MARK:- Requests
    func getAllCatSelect(at sectionId: Int, callback: @escaping (RequestComplite, MenuSection?) -> ()){
        MenuAPI.requstObjectMenuSection(type: MenuSectionsModel.self, request: .getSelectSectionMenu(section_id: sectionId), delegate: delegate) { [weak self] (responce) in
            if let responce = responce{
                if let success = responce.success, success{
                    callback(.complite, responce.dataWithCat)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error, nil)
                }
            }
            else{
                callback(.error, nil)
            }
        }
    }
    
    func requestSearchDish(from title: String, callback: @escaping (RequestComplite) -> ()){
        MenuAPI.requstObjectMenuSection(type: SearchDishModel.self, request: .searchDish(title: title), delegate: delegate) { [weak self] (responce) in
            if let responce = responce{
                if let success = responce.success, success{
                    self?.searchEatModel = responce.data ?? []
                    callback(.complite)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
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
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
