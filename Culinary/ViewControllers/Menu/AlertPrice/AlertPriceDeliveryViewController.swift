//
//  AlertPriceDeliveryViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AlertPriceDeliveryViewController: UIViewController {
    
    @IBOutlet weak var viewOnEffectV: UIView!
    @IBOutlet weak var viewVisualEffect: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewVisualEffect.alpha = 0.0
        self.viewVisualEffect.effect = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.8) {
            self.viewVisualEffect.effect = UIBlurEffect(style: .regular)
            self.viewVisualEffect.alpha = 1.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @IBAction func close(_ sender: UIButton){
        dismiss(animated: false, completion: nil)
    }
    

    //MARK:- deinit
    deinit{
        print("AlertPriceDeliveryViewController is deinit")
    }

}
