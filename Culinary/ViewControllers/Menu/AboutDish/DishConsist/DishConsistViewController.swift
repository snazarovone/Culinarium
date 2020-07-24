//
//  DishConsistViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DishConsistViewController: UIViewController {
    
    var pageIndex = 0
    var pageTitle = "СОСТАВ"
    var consist = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //MARK:- deinit
    deinit{
        print("DishConsistViewController is deinit")
    }
}

extension DishConsistViewController: UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.dishConsist.identifire) as! DishConsistTableViewCell
        cell.consistText.text = self.consist
        return cell
    }
    
}

extension DishConsistViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle )
    }
}

