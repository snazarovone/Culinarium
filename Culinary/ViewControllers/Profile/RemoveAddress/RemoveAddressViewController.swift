//
//  RemoveAddressViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class RemoveAddressViewController: UIViewController {
    
    public var isRemove: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancel(_ sender: UIButton){
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func remove(_ sender: UIButton){
        dismiss(animated: false) {
            self.isRemove?()
        }
    }

    //MARK:- RemoveAddressViewController
    deinit{
        print("RemoveAddressViewController is deinit")
    }

}
