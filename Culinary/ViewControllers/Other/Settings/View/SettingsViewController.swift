//
//  SettingsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- deinit
    deinit{
        print("SettingsViewController is deinit")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.viewFromNibName(name: "SettingsHeader") as! SettingsHeaderView
        
        switch section {
        case 0:
            header.titleHeader.text = "ОСНОВНЫЕ"
        case 1:
            header.titleHeader.text = "ПРАВОВЫЕ"
        default:
            return nil
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            performSegue(withIdentifier: SegueID.informationProgramm.id, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56.0
    }
}
