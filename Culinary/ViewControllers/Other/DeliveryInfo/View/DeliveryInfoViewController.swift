//
//  DeliveryInfoViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var deliveryViewModel = DeliveryInfoViewModel()
    
    private weak var basketDelegate: BasketDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        basketDelegate = self
    }
    
    //MARK:- deinit
    deinit{
        print("DeliveryInfoViewController is deinit")
    }
}

extension DeliveryInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryViewModel.numberRow(of: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = deliveryViewModel.cellForRow(at: indexPath)
        
        switch dataCell.deliveryCellType {
        case .menu:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketMenuItem.identifire) as! BMenuItemTableViewCell
            cell.dataMenu = dataCell as? BMenuTableCellViewModelType
            cell.menuDelegate = basketDelegate as? MenuDelegate
            return cell
        case .description1Line:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.deliveryInfo1Line.identifire) as! DeliveryInfoTableViewCell
            cell.dataDelivery = dataCell as? DeliveryInfoCellViewModelType
            return cell
        case .description2Line:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.deliveryInfo2Line.identifire) as! DeliveryInfoTableViewCell
            cell.dataDelivery = dataCell as? DeliveryInfoCellViewModelType
            return cell
        case .description2Line2Col:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.deliveryInfo2Line2Col.identifire) as! DeliveryInfoTableViewCell
            cell.dataDelivery = dataCell as? DeliveryInfoCellViewModelType
            return cell
        }
    }
    
}

extension DeliveryInfoViewController: MenuDelegate{

    func didSelectMenu(at indexPath: IndexPath) {
        print(indexPath.row)
        self.deliveryViewModel.changeDataMenuDelegate(currentIndex: indexPath.row)
    }
}
