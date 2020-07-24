//
//  AboutSeasonATicketViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutSeasonATicketViewController: UIViewController {

    @IBOutlet weak var titleAboutSeasonATicket: UILabel!
    @IBOutlet weak var pictureAboutSeasonATicket: UIImageView!
    @IBOutlet weak var activate_btn: UIButtonDesignable!
    @IBOutlet weak var descriptionAboutSeasonATicket: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- Share
        if let identifier = segue.identifier, identifier == SegueID.share.id{
            if let dvc = segue.destination as? ShareViewController{
                dvc.shareViewModel = ShareViewModel(shareType: .seasonTicket)
            }
        }
    }
    
    @IBAction func share(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueID.share.id, sender: nil)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func activate(_ sender: UIButton) {
    }
    
    //MARK:- deinit
    deinit{
        print("AboutSeasonATicketViewController is deinit")
    }
}
