//
//  AboutOrderViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutOrderViewController: UIViewController {
    
    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var positionOrder: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    public var aboutOrderViewModel: AboutOrderViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 32.0, right: 0.0)
        
        numberOrder.text = aboutOrderViewModel.numberOrder
        positionOrder.text = aboutOrderViewModel.position
    }
    

    //MARK:- deinit
    deinit {
        print("AboutOrderViewController is deinit")
    }

}

extension AboutOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutOrderViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = aboutOrderViewModel.cellForRow(at: indexPath)
        switch cellData.type {
        case .dishOrder:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.aboutOrderDish.identifire) as! AboutOrderDishTableViewCell
            cell.dataAboutDish = cellData as? AboutOrderDishCellViewModelType
            return cell
        case .infoOrder:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.aboutOrderInfo.identifire) as! AboutOrderInfoTableViewCell
            cell.dataOrder = aboutOrderViewModel.cellForRow(at: indexPath) as? AboutOrderInfoCellViewModelType
            return cell
        }
    }
    
    
}
