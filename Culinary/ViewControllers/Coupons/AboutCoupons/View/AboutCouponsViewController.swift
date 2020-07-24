//
//  AboutCouponsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutCouponsViewController: UIViewController {
    
    @IBOutlet weak var titleCoupon: UILabel!
    @IBOutlet weak var qr_btn: UIButton! //меняется на "Подробности"
    @IBOutlet weak var play_btn: UIButton! //меняется на "Пауза"
   
    //hidden по нажатию на "Смотреть Qr-код"
    @IBOutlet weak var descriptionCoupon: UITextView!
    @IBOutlet weak var timeCoupon: UIStackView!
    @IBOutlet weak var timeCountCoupon: UILabel! //2 дня
    
    //по умолчанию image купона меняется на изображение qr-code по нажатию на "Смотреть Qr-код"
    @IBOutlet weak var pictureCoupon: UIImageView!
    
    //PRIVATE
    private var aboutCouponsViewModel: AboutCouponsViewModel?
    
    //PUBLIC
    public var typeAbout: ShareType = .coupons //or seasonTickets

    override func viewDidLoad() {
        super.viewDidLoad()
        aboutCouponsViewModel = AboutCouponsViewModel(stateShowCoupons: .description)
        setupViewController()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if aboutCouponsViewModel == nil{
            return .lightContent
        }else{
            if aboutCouponsViewModel?.stateShowCoupons == .qr{
                return .default
            }else{
                return .lightContent
            }
        }
    }
    

    //MARK:- DataSourceView
    private func setupViewController(){
        self.qr_btn.setTitle(self.aboutCouponsViewModel?.stateShowCoupons.titleBtn, for: .normal)
        
        self.pictureCoupon.contentMode = self.aboutCouponsViewModel!.stateShowCoupons.picture.1
        self.pictureCoupon.image = self.aboutCouponsViewModel!.stateShowCoupons.picture.0
        
        self.descriptionCoupon.isHidden = self.aboutCouponsViewModel!.stateShowCoupons.isDescription
        self.timeCoupon.isHidden = !self.descriptionCoupon.isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- Share
        if let identifier = segue.identifier, identifier == SegueID.share.id{
            if let dvc = segue.destination as? ShareViewController{
                dvc.shareViewModel = ShareViewModel(shareType: typeAbout)
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: UIButton){
        self.performSegue(withIdentifier: SegueID.share.id, sender: nil)
    }
    
    @IBAction func showQrCode(_ sender: UIButton){
        if aboutCouponsViewModel?.stateShowCoupons == .description{
            aboutCouponsViewModel?.stateShowCoupons = .qr
        }else{
            aboutCouponsViewModel?.stateShowCoupons = .description
        }
        setupViewController()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func play(_ sender: UIButton){
        if sender.tag == 0{
            play_btn.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            sender.tag = 1
            sender.imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            performSegue(withIdentifier: SegueID.freez.id, sender: nil)
        }else{
            play_btn.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            sender.tag = 0
            sender.imageEdgeInsets =  UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        }
    }
    
    
    //MARK:- deinit
    deinit{
        print("AboutCouponsViewController is deinit")
    }
}
