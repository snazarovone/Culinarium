//
//  HowGetBallsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HowGetBallsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewWillAppear(animated)
    }
    
    //MARK:- Actions
    @IBAction func openMenu(_ sender: UIButton){
        
    }
    
    @IBAction func invateFrends(_ sender: UIButton){
        
    }
    
    @IBAction func listTask(_ sender: UIButton){
        
    }

    // MARK: - deinit
    deinit{
        print("HowGetBallsViewController is deinit")
    }
}
