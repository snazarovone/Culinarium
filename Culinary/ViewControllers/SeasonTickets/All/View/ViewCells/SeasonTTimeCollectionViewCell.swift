//
//  SeasonTTimeCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SeasonTTimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var prictureSeasonT: UIImageViewDesignable!
    @IBOutlet weak var titleSeasonT: UILabel!
    @IBOutlet weak var time_btn: UIButtonDesignable! //ОСТАЛОСЬ 5 Ч
    
    @IBOutlet weak var bottomGView: NSLayoutConstraint!
    @IBOutlet weak var leadingGView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomGBtn: NSLayoutConstraint!
    @IBOutlet weak var leadingGBtn: NSLayoutConstraint!
    
    private weak var seasontTicketTimeDelegate: SeasontTicketTimeDelegate?
    
    weak var dataSeasonT: SeasonTTimeCellViewModelType?{
        willSet(data){
            seasontTicketTimeDelegate = data?.seasontTicketTimeDelegate
            
            //если представление в виде сетки, ячейки будут маленькими, меням отступы
            if let viewCollection = data?.viewCollection, viewCollection == .grid{
                //ячейки экрана абонементы в виде сетки
                bottomGBtn.constant = 4.0
                leadingGBtn.constant = 4.0
                bottomGView.constant = 4.0
                leadingGView.constant = 4.0
                titleSeasonT.font = UIFont(name:"Rubik-Medium", size:13.0)!
                time_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:12.0)!
            }else{
                if data?.viewCollection == nil{
                    //ячейки на главном табе
                    bottomGBtn.constant = 8.0
                    leadingGBtn.constant = 8.0
                    bottomGView.constant = 8.0
                    leadingGView.constant = 8.0
                    titleSeasonT.font = UIFont(name:"Rubik-Medium", size:15.0)!
                    time_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:12.0)!
                }else{
                    //ячейки экрана абонементы в виде карточек
                    bottomGBtn.constant = 16.0
                    leadingGBtn.constant = 16.0
                    bottomGView.constant = 16.0
                    leadingGView.constant = 16.0
                    titleSeasonT.font = UIFont(name:"Rubik-Medium", size:18.0)!
                    time_btn.titleLabel?.font = UIFont(name:"Rubik-Medium", size:16.0)!
                }
            }
        }
    }
    
    @IBAction func timeAction(_ sender: UIButton) {
        seasontTicketTimeDelegate?.showSeasonTicketTime()
    }
    
}
