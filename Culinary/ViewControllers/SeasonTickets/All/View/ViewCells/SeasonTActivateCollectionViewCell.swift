//
//  SeasonTActivateCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SeasonTActivateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var prictureSeasonA: UIImageViewDesignable!
    @IBOutlet weak var titleSeasonA: UILabel!
    @IBOutlet weak var activate_btn: UIButtonDesignable! //ОСТАЛОСЬ 5 Ч
    
    @IBOutlet weak var bottomAView: NSLayoutConstraint!
    @IBOutlet weak var leadingAView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomABtn: NSLayoutConstraint!
    @IBOutlet weak var leadingABtn: NSLayoutConstraint!
    
    private weak var seasontTicketActivateDelegate: SeasontTicketActivateDelegate?
    
    weak var dataSeasonActivate: SeasonTActivateCellViewModelType?{
        willSet(data){
            seasontTicketActivateDelegate = data?.seasontTicketActivateDelegate
            //если представление в виде сетки, ячейки будут маленькими, меням отступы
            if let viewCollection = data?.viewCollection, viewCollection == .grid{
                //ячейки экрана абонементы в виде сетки
                bottomABtn.constant = 4.0
                leadingABtn.constant = 4.0
                bottomAView.constant = 4.0
                leadingAView.constant = 4.0
                titleSeasonA.font = UIFont(name:"Rubik-Medium", size:13.0)!
                activate_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:12.0)!
            }else{
                if data?.viewCollection == nil{
                    //ячейки на главном табе
                    bottomABtn.constant = 8.0
                    leadingABtn.constant = 8.0
                    bottomAView.constant = 8.0
                    leadingAView.constant = 8.0
                    titleSeasonA.font = UIFont(name:"Rubik-Medium", size:15.0)!
                    activate_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:12.0)!
                }else{
                    //ячейки экрана абонементы в виде карточек
                    bottomABtn.constant = 16.0
                    leadingABtn.constant = 16.0
                    bottomAView.constant = 16.0
                    leadingAView.constant = 16.0
                    titleSeasonA.font = UIFont(name:"Rubik-Medium", size:18.0)!
                    activate_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:16.0)!
                }
            }
        }
    }
    
    
    @IBAction func activate(_ sender: UIButton) {
        seasontTicketActivateDelegate?.showSeasontTicketActivate()
    }
}
