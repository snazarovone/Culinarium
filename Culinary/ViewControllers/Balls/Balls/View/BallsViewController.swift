//
//  BallsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 06.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //PRIVATE
    private var ballsViewModel: BallsViewModel!
    private weak var ballsDelegate: BallsEarnDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballsDelegate = self
        ballsViewModel = BallsViewModel(ballsDelegate: ballsDelegate)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
    
    //MARK:- deinit
    deinit{
        print("BallsViewController is deinit")
    }
}

//MARK:- TableView
extension BallsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ballsViewModel.numberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = ballsViewModel.cellForRowAt(at: indexPath)
        switch cellData.ballsEarnCellType{
        case .feedback:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballEarnFeedback.identifire) as! BallsFeedbackTableViewCell
            cell.dataFeedback = cellData as? BallsFeedbackCellViewModelType
            return cell
        case .share:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballEarnShare.identifire) as! BallsShareTableViewCell
            cell.dataShare = cellData as? BallsShareCellViewModelType
            return cell
        case .buyer:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballEarnBuyer.identifire) as! BallsBuyerTableViewCell
            cell.dataBuyer = cellData as? BallsBuyerCellViewModelType
            return cell
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballEarnProfile.identifire) as! BallsProfileTableViewCell
            cell.dataProfile = cellData as? BallsProfileCellViewModelType
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}



//MARK:- Action Feedback
extension BallsViewController: BallsFeedbackDelegate{
    func feedbackAction() {
        print("feedbackAction")
    }
}

//MARK:- Action Share
extension BallsViewController: BallsShareDelegate{
    func vk() {
        print("vk")
    }
    
    func fb() {
        print("fb")
    }
    
    func instagramm() {
        print("instagramm")
    }
}

//MARK:- Action Buyer
extension BallsViewController: BallsBuyerDelegate{
    func participate() {
        print("participate")
    }
}

//MARK:- Action Profile
extension BallsViewController: BallsProfileDelegate{
    func fillOutForm() {
        print("fillOutForm")
    }
}
