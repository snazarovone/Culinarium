//
//  OrganizeViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrganizeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //PRIVATE
    private var organizeViewModel = OrganizeViewModel()
    private weak var organizeDelegate: OrganizeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        organizeDelegate = self
    }
    

    //MARK:- deinit
    deinit{
        print("OrganizeViewController is deinit")
    }

}

extension OrganizeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizeViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = organizeViewModel.cellForRow(at: indexPath)
        switch cellData.organizeTableCellType {
        case .menu:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.orgMenu.identifire) as! OrgMenuTableViewCell
            cell.dataMenu = cellData as? OrgMenuTableCellViewModelType
            cell.menuDelegate = organizeDelegate as? MenuDelegate
            return cell
        case .slideShow:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.orgSlideShowTableCell.identifire) as! OrgSlideShowTableCell
            cell.dataSlideShow = cellData as? OrgSlideShowTableCellViewModelType
            cell.slideShowDelegate = organizeDelegate as? SlideShowDelegate
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.orgInfo.identifire) as! OrgInfoTableViewCell
            cell.dataInfo = cellData as? OrgInfoCellViewModelType
            return cell
        case .descriptionOrg:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.orgDescription.identifire) as! OrgDescriptionTableViewCell
            cell.dataDescription = cellData as? OrgDescriptionViewModelType
            return cell
        }
    }
    
}

extension OrganizeViewController: MenuDelegate{
    
    func didSelectMenu(at indexPath: IndexPath) {
        self.organizeViewModel.changeDataMenuDelegate(at: indexPath)
        self.tableView.reloadData()
    }
}

extension OrganizeViewController: SlideShowDelegate{
    func didChangePage(at page: Int) {
        self.organizeViewModel.changeDataSlideShowDelegate(at: page)
    }
    
}
