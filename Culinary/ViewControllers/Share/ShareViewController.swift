//
//  ShareViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var shareTitle: UILabel?
    @IBOutlet weak var shareDescription: UILabel?
    
    public var shareViewModel: ShareViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK:- Helpers
    private func setupView(){
        shareTitle?.text = shareViewModel.shareType.title
        shareDescription?.attributedText = shareViewModel.shareType.description
    }
    
    //MARK:- Actions
    @IBAction func linkShare(_ sender: UIButton){
        
    }
    
    @IBAction func vkShare(_ sender: UIButton){
        
    }
    
    @IBAction func fbShare(_ sender: UIButton){
        
    }
    
    @IBAction func telegaShare(_ sender: UIButton){
        
    }
    
    @IBAction func whatsUpShare(_ sender: UIButton){
        
    }
    
    @IBAction func closeClose(_ sender: UIButton){
        dismiss(animated: false, completion: nil)
    }

    //MARK:- deinit
    deinit{
        print("ShareViewController is deinit")
    }
}
