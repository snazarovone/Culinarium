//
//  AboutCafeViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwiftOverlays
import MapKit
import RxSwift
import RxCocoa

class AboutCafeViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var orgSlideCollectionViewModel: OrgSlideCollectionViewModel!
    private var aboutCafeViewModel:AboutCafeViewModel!
    private let locationManager = CLLocationManager()
    private var myLocation: (String, String)?
    private weak var tabBarVC: TabBarViewController!
    
    public var cafe: Cafe!
    
    
    weak var cafeVCDelegate: CafeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTabBarVC()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        aboutCafeViewModel = AboutCafeViewModel(aboutCafe: cafe)
        
        orgSlideCollectionViewModel = OrgSlideCollectionViewModel(items: cafe.gallery ?? [])
        pageControl.numberOfPages = Int(cafe.gallery?.count ?? 0)
        pageControl.currentPage = 0
    }
    
    //MARK:- Request Feedback
    private func requestFeedbackAboutCafe(){
        showWaitOverlay()
        aboutCafeViewModel.requestFeedbackAboutCafe { [weak self] (result) in
            self?.removeAllOverlays()
            
            switch result{
            case .complite:
                self?.aboutCafeViewModel.getDataModel()
                self?.tableView.reloadData()
            case .error:
                if self?.aboutCafeViewModel.getAuth() != nil{
                    self?.dismiss(animated: true) {
                        //открываем форму авторизации
                        self?.cafeVCDelegate?.logout()
                    }
                }
            }
        }
    }
    
    private func getTabBarVC(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
        
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                self.tabBarVC = tabBarVC
                return
            }
        }
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
            self.tabBarVC = tabBarVC
        }
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.fillFeedback.id{
            if let dvc = segue.destination as? FillFeedbackViewController{
                let idCafe = aboutCafeViewModel.getIdCafe()
                
                dvc.fillFeedbackViewModel = FillFeedbackViewModel(selectHeader: .aboutCafe, listCafe: tabBarVC.listCafe, idSelectCafe: idCafe, idSelectDish: nil, userInfo: tabBarVC.userInfo, dishesMainInfo: tabBarVC.dishesMainInfo)
                dvc.aboutCafeDelegate = self
            }
        }
    }

    //deinit
    deinit{
        print("AboutCafeViewController is deinit")
    }
}

//MARK:- TableView
extension AboutCafeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutCafeViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = aboutCafeViewModel.cellForRow(at: indexPath)
        switch dataCell.typeCell {
        case .addressCafe:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.addressCafe.identifire) as! AddressCafeTableViewCell
            cell.dataAddress = dataCell as? AddressCafeCellModelType
            cell.cafeDelegate = self
            return cell
        case .infoCafe:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.infoCafe.identifire) as! InfoCafeTableViewCell
            cell.dataInfoCafe = dataCell as? InfoCafeCellViewModelType
            return cell
        case .titleFeedback:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.titleFeedback.identifire)!
          
            if aboutCafeViewModel.isGetFeedback() == false{
                //запрашиваем все отзывы о кафе
                requestFeedbackAboutCafe()
            }
            return cell
        case .feedback:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.feedBack.identifire) as! FeedbackTableViewCell
            cell.dataFeedback = aboutCafeViewModel.cellForRow(at: indexPath) as? FeedbackCellViewModelType
            return cell
        }
    }
    
}

//MARK:- CollectionView
extension AboutCafeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orgSlideCollectionViewModel.numberOfRow(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.orgSlideCollection.identifire, for: indexPath) as! OrgSlideCollectionViewCell
        cell.dataSlide = orgSlideCollectionViewModel!.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return .zero
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          CGSize(width: 320.0, height: 168.0)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView{
            let pageIndex = round(scrollView.contentOffset.x/320.0)
            pageControl.currentPage = Int(pageIndex)
            orgSlideCollectionViewModel?.changePage(at: Int(pageIndex))
        }
    }
    
}

extension AboutCafeViewController: AboutCafeDelegate{
    func call() {
        guard let phone = aboutCafeViewModel.getPhoneNumber() else {
            return
        }
        
        phone.makeACall()
    }
    
    func route() {
        
        guard let locStr = aboutCafeViewModel.locationForYandexMap(), let myLoc = myLocation else{
            return
        }
        
        let url = URL(string: "yandexmaps://build_route_on_map/?lat_from=\(myLoc.0)&lon_from=\(myLoc.1)&lat_to=\(locStr.0)&lon_to=\(locStr.1)")!
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return
        }
        
        //apple map
        
        guard let coordinate = aboutCafeViewModel.getLocation() else{
            return
        }
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        source.name = aboutCafeViewModel.getNameCafe()
  
        MKMapItem.openMaps(with: [source], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    func feedback() {
        performSegue(withIdentifier: SegueID.fillFeedback.id, sender: nil)
    }
    
    func logoutFromCafe() {
        dismiss(animated: false) {
            self.cafeVCDelegate?.logout()
        }
    }
}


extension AboutCafeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        myLocation = ("\(Double(locValue.latitude))", "\(Double(locValue.longitude))")
    }
}

