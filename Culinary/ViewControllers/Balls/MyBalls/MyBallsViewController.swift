//
//  MyBallsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 06.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsViewController: UIViewController {
    
    private weak var ballsDelegate: BallsDelegate!
    
    var ballsCell: BallsTableCellViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        ballsDelegate = self
        ballsCell = BallsTableCellViewModel(tabMainCellType: .tabMainBalls, tabMainDelegate: ballsDelegate)
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballsMy.identifire)!
            return cell
        }else{
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballsHistory.identifire)!
                return cell
            }else{
                if indexPath.row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainBalls.identifire) as! BallsTableViewCell
                                
                    cell.dataBalls = ballsCell
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.ballAction.identifire)!
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 544.0
        }else{
            if indexPath.row == 1{
                return 382.0
            }else{
                if indexPath.row == 2 {
                    return 384.0
                }else{
                    return 138.0
                }
            }
        }
    }
    
    
}

extension MyBallsViewController: BallsDelegate{
    func showEarnBalls() {
         performSegue(withIdentifier: SegueID.balls.id, sender: nil)
    }
}
