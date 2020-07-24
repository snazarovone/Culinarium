//
//  HowSpendBallsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HowSpendBallsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - deinit
    deinit{
        print("HowSpendBallsViewController is deinit")
    }

}
