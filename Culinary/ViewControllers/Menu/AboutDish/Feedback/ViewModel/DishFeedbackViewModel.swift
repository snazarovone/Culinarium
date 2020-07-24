//
//  DishFeedbackViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DishFeedbackViewModel{
    
    private var dishId: Int
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    private var feedback = [FeedUser]()
    private var auth: ErrorAuth? = nil
    
    init(dishId: Int){
        self.dishId = dishId
    }
    
    public func requestGetFeedback(callback: @escaping (RequestComplite) -> ()){
        FeedbackAPI.requstObjectFeedback(type: FeedbackModel.self, request: .getFeedbackDish(dishId: dishId), delegate: delegate) {
            [weak self] (responce) in
            if let responce = responce{
                if let success = responce.success, success{
                    self?.feedback = responce.data ?? []
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
    
    func idDish() -> Int{
        return dishId
    }
}


extension DishFeedbackViewModel: DishFeedbackViewModelType{
    func numberOfRow() -> Int {
        return feedback.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> FeedbackCellViewModelType {
        return FeedbackCellViewModel(feedback: feedback[indexPath.row])
    }
    
}
