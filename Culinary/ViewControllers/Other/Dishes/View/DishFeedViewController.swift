//
//  DishFeedViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class DishFeedViewController: UIViewController {
    
    public var dishFeedViewModel: DishFeedViewModel!
    public var didSelectCafe: ((Int?)->())?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //MARK:- deinit
    deinit{
        print("DishFeedViewController is deinit")
    }
}

extension DishFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishFeedViewModel.numberForRaw()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.dishFeed.identifire) as! DishFeedTableViewCell
        cell.dataDish = dishFeedViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCafe?(dishFeedViewModel.didSelectRow(at: indexPath))
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        }else{
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
