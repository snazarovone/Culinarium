//
//  FeedbackViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    //MARK:- Actions
    @IBAction func close(_ sender: UIButton){
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func call(_ sender: UIButton){
        guard let url = URL(string: "tel://+74959787897") else {
        return //be safe
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func backCall(_ sender: UIButton){
        performSegue(withIdentifier: SegueID.backCall.id, sender: nil)
    }
    
    //MARK:- Deinit
    deinit{
        print("FeedbackViewController is deinit")
    }
}
