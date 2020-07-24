//
//  DishDescriptionViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DishDescriptionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pageIndex = 0
    var pageTitle = "ОПИСАНИЕ"
    var descriptionDish: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit{
           print("DishDescriptionViewController is deinit")
       }
    
}

extension DishDescriptionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.dishDescription.identifire) as! DishDescTableViewCell
        cell.descText.text = self.descriptionDish
        return cell
    }
    
    
}

extension DishDescriptionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle )
    }
}
