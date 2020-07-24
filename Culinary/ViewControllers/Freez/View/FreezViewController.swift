//
//  FreezViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FreezViewController: UIViewController {
    
    @IBOutlet weak var titleFreez: UILabel!
    @IBOutlet weak var descFreez: UILabel!
    @IBOutlet weak var dropDownList: UIView!
    @IBOutlet weak var dropDown_Btn: UIButton!
    @IBOutlet weak var centrView: NSLayoutConstraint!
    
    private var freezViewModel = FreezViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDownList.alpha = 0.0
        self.dropDown_Btn.setTitle(self.freezViewModel.daysModel[self.freezViewModel.selectDays.row].title, for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- List Days
        if let id = segue.identifier, id == SegueID.listDays.id{
            if let dvc = segue.destination as? ListDaysViewController{
                dvc.listDaysViewModel = ListDaysViewModel(daysModel: freezViewModel.daysModel, selectIndex: freezViewModel.selectDays)
                
                dvc.selectDay = {
                    [weak self] indexPath in
                    self?.freezViewModel.selectDays = indexPath
                    self?.dropDown_Btn.setTitle(self?.freezViewModel.daysModel[indexPath.row].title, for: .normal)
                    self?.hideDropList()
                }
            }
        }
    }
    
    //MARK:- Helpers
    private func showDropList(){
        DispatchQueue.main.async {
            self.dropDownList.alpha = 0.0
            self.moveCenter(dropDownShow: true)
            UIView.animate(withDuration: 1.0) {
                self.dropDownList.alpha = 1.0
            }
        }
    }
    
    private func hideDropList(){
        DispatchQueue.main.async {
            self.dropDownList.alpha = 1.0
            self.moveCenter(dropDownShow: false)
            UIView.animate(withDuration: 1.0) {
                self.dropDownList.alpha = 0.0
            }
        }
    }
    
    private func moveCenter(dropDownShow: Bool){
        if dropDownShow{
            centrView.constant = centrView.constant - 72.0
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }else{
            centrView.constant = centrView.constant + 72.0
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton){
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func freez(_ sender: UIButton){
        //передать информацию о заморозке
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func showDropList(_ sender: UIButton){
        showDropList()
    }

    //MARK:- deinit
    deinit{
        print("FreezViewController is deinit")
    }

}
