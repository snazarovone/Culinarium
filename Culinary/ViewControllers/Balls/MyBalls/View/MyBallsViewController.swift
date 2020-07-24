//
//  MyBallsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 06.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsViewController: UIViewController {
    
    //PRIVATE
    private var myBallsViewModel: MyBallsViewModel!
    private weak var ballsDelegate: BallsDelegate?
    private weak var myBallsDelegate: MyBallsDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ballsDelegate = self
        myBallsDelegate = self
        myBallsViewModel = MyBallsViewModel(ballsDelegate: ballsDelegate, myBallsDelegate: myBallsDelegate)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }

    //MARK:- Actions
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- deinit
    deinit{
        print("MyBallsViewController is deinit")
    }

}

extension MyBallsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBallsViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = myBallsViewModel.cellForRow(at: indexPath)
        switch cellData.myBallsCellType{
        case .myBonus:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballsMy.identifire) as! MyBonusTableViewCell
            cell.dataMyBonus = cellData as? MyBonusCellViewModelType
            return cell
        case .history:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballsHistory.identifire) as! MyBallsHistoryTableViewCell
            cell.dataHistory = cellData as? MyBallsHistoryCellViewModelType
            return cell
        case .getBalls:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainBalls.identifire) as! BallsTableViewCell
            cell.dataBalls = cellData as? BallsTableCellViewModelType
            return cell
        case .actions:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballAction.identifire) as! MyBallsActionsTableViewCell
            cell.dataActions = cellData as? MyBallsActionsCellViewModelType
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellData = myBallsViewModel.cellForRow(at: indexPath)
        return cellData.heightCell
    }
    
    
}

extension MyBallsViewController: BallsDelegate{
    func logout() {
    }
    
    func showEarnBalls() {
         performSegue(withIdentifier: SegueID.balls.id, sender: nil)
    }
}

//MARK:- Actions Cell MyBonus
extension MyBallsViewController: MyBonusDelegate{
    func howGetBalls() {
        performSegue(withIdentifier: SegueID.howGetBalls.id, sender: nil)
    }
    
    func howSpendBalls() {
        performSegue(withIdentifier: SegueID.howSpendBalls.id, sender: nil)
    }
}
