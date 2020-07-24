//
//  DishFeedbackViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftOverlays
import RxSwift
import RxCocoa

class DishFeedbackViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pageIndex = 0
    var pageTitle = "ОПИСАНИЕ"
    var dishFeedbackViewModel: DishFeedbackViewModel!
    weak var dishMainDelegate: DishMainViewDelegate?
    
    private weak var tabBarVC: TabBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTabBarVC()
        
        dishMainDelegate?.dishShowWaitOverlay()
        dishFeedbackViewModel.requestGetFeedback { [weak self] (requestComplite) in
            self?.dishMainDelegate?.dishRemoveWaitOverlay()
            switch requestComplite{
            case .complite:
                self?.tableView.reloadData()
            case .error:
                guard self?.dishFeedbackViewModel.getAuth() != nil else {return}
                //проверил
                self?.dishMainDelegate?.logOut()
            }
        }
    }
    
    private func getTabBarVC(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
       
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                self.tabBarVC = tabBarVC
                return
            }
        }
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
             self.tabBarVC = tabBarVC
        }
    }
    
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.fillFeedback.id{
            if let dvc = segue.destination as? FillFeedbackViewController{
                dvc.fillFeedbackViewModel = FillFeedbackViewModel(selectHeader: .aboutDish, listCafe: tabBarVC.listCafe, idSelectCafe: nil, idSelectDish: dishFeedbackViewModel.idDish(), userInfo: tabBarVC.userInfo, dishesMainInfo: tabBarVC.dishesMainInfo)
                dvc.dishMainDelegate = dishMainDelegate
            }
            return
        }
    }
    
    //MARK:- Actions
    @IBAction func writeFeedback(){
        performSegue(withIdentifier: SegueID.fillFeedback.id, sender: nil)
    }
    
    deinit{
        print("DishFeedbackViewController is deinit")
    }
}

extension DishFeedbackViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishFeedbackViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.feedBack.identifire) as! FeedbackTableViewCell
        cell.dataFeedback = dishFeedbackViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DishFeedbackViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle )
    }
}

