//
//  ListDaysViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class ListDaysViewController: UIViewController {
    
    public var selectDay: ((IndexPath)->())?
    public var listDaysViewModel: ListDaysViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //MARK:- deinit
    deinit{
        print("ListDaysViewController is deinit")
    }
}

extension ListDaysViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDaysViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.day.identifire) as! DayTableViewCell
        cell.titleDay.text = listDaysViewModel.cellForRow(at: indexPath).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listDaysViewModel.didSelectRow(at: indexPath)
        DispatchQueue.main.async {
            if let selectDay = self.selectDay{
                selectDay(indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
}
