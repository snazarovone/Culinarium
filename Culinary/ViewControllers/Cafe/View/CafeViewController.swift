//
//  CafeViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
import YandexMapKit
import RxSwift
import RxCocoa
import SwiftOverlays
import MapKit

class CafeViewController: UIViewController {
    
    @IBOutlet weak var myLocation: UIButtonDesignable!
    @IBOutlet weak var mapView: YMKMapView!
    @IBOutlet weak var onMapBtn: UIButtonDesignable!
    @IBOutlet weak var listBtn: UIButtonDesignable!
    @IBOutlet weak var containerListCafe: UIView! //hide on default
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var userLocationLayer: YMKUserLocationLayer?
//    private var lastUserCoordinate: YMKPoint?
    
    private var stateCafeSW = StateCafeShow.onMap
    
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private let animator: LayoutAttributesAnimator = LinearCardAttributesAnimator(minAlpha: 1.0, itemSpacing: 0.26 , scaleRate: 0.83)
    private var placemarks = [YMKPlacemarkMapObject]()
    
    private var isMyLoc = false
    private var zoom: Float = 14.0
    
    public var cafeViewModel: CafeViewModel!
    private let disposeBag = DisposeBag()
    
    private var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: UserInfo())
    private weak var listCafeViewModel: ListCafeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafeViewModel = CafeViewModel(listCafe: getListCafe())
        userInfo = getUserInfo()
        
        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = animator
        }
        
        setupMyLocation()
        subscribes()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewWillAppear(animated)
    }
    
    //MARK:- Get List Cafe
    private func getListCafe() -> BehaviorRelay<CafeModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.listCafe
        }else{
            let model: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- UserInfo
    private func getUserInfo() -> BehaviorRelay<UserInfo?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.userInfo
        }else{
            let model: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- AllDishes
    private func getAllDish() -> BehaviorRelay<[DishMainInfo]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.dishesMainInfo
        }else{
            let model: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    //MARK:- LocationManager
    private func getLocationManager() -> CLLocationManager?{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.locationManager
        }else{
            return nil
        }
    }
    
    
    //MARK:- Subscribes
    private func subscribes(){
        cafeViewModel.getFilterListCafe().asObservable().subscribe(onNext: { [weak self] (value) in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
                self?.createPlacemark(cafes: value?.cafes ?? [])
                self?.listCafeViewModel?.filterListCafe.accept(value)
                
                self?.collectionView?.performBatchUpdates(nil, completion: nil)
                
                if let self = self{
                    if self.cafeViewModel.indexPath.row >= value?.cafes?.count ?? 0{
                        let locManager = self.getLocationManager()
                        let manager = locManager?.location?.coordinate
                        
                        self.myLocation.setImage(UIImage(named: "loc_red")!, for: .normal)
                        self.isMyLoc = true
                        
                        let z = self.mapView.mapWindow.map.cameraPosition.zoom
                        self.mapView.mapWindow.map.move(with:
                            YMKCameraPosition(target: YMKPoint(latitude: manager?.latitude ?? 55.7522200, longitude: manager?.longitude ?? 37.6155600), zoom: z, azimuth: 0, tilt: 0))
                    }else{
                        if let cafeLatStr = value?.cafes?[self.cafeViewModel.indexPath.row].lat, let cafeLonStr = value?.cafes?[self.cafeViewModel.indexPath.row].lng, let lat = Double(cafeLatStr), let lon = Double(cafeLonStr){
                            let z = self.mapView.mapWindow.map.cameraPosition.zoom
                            self.isMyLoc = false
                            self.mapView.mapWindow.map.move(with:
                                YMKCameraPosition(target: YMKPoint(latitude: lat, longitude: lon), zoom: z, azimuth: 0, tilt: 0))
                        }
                    }
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        cafeViewModel.listCafe.subscribe(onNext: { [weak self] (value) in
            for cafeList in value?.cafes ?? []{
                for fCafe in self?.cafeViewModel.getFilterListCafe().value?.cafes ?? []{
                    if let idCafe = cafeList.id, let idFCafe = fCafe.id, idCafe == idFCafe{
                        fCafe.distance = cafeList.distance
                    }
                }
            }
            self?.collectionView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Request Cafe by Filters
    private func requestCafeByFilters(){
        showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        let locManager = getLocationManager()
        cafeViewModel.requestCafeByFilters(lat: locManager?.location?.coordinate.latitude, lon: locManager?.location?.coordinate.longitude) { [weak self] (result) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                break
            case .error:
                if self?.cafeViewModel.getAuth() != nil{
                    //открываем форму авторизации
                    self?.logout()
                }
            }
        }
    }
    
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.listCafe.id{
            if let dvc = segue.destination as? ListCafeViewController{
                
                self.listCafeViewModel = dvc.listCafeViewModel
                dvc.listCafe = getListCafe()
                
                dvc.cafeVCDelegate = self
                dvc.userInfo = getUserInfo()
                dvc.dishesMainInfo = getAllDish()
                
                dvc.hideListCafe = {
                    [weak self] in
                    self?.containerListCafe.isHidden = true
                }
                
                dvc.showFilter = {
                    [weak self] in
                    self?.showFilters()
                }
            }
            return
        }
        if let identifier = segue.identifier, identifier == SegueID.filter.id{
            if let dvc = segue.destination as? FilterViewController{
                dvc.filterViewModel = FilterViewModel(filterCafe: cafeViewModel.cafeFilters)
                dvc.isNewFilter = {
                    [requestCafeByFilters] in
                    //запросить список кафе по фильтрам
                    requestCafeByFilters()
                }
            }
            return
        }
        
        //MARK:- about cafe
        if let identifier = segue.identifier, identifier == SegueID.aboutCafe.id{
            if let dvc = segue.destination as? AboutCafeViewController{
                dvc.cafe = sender as? Cafe
                dvc.cafeVCDelegate = self
            }
            return
        }
        
    }
    
    //MARK:- Filters
    private func showFilters(){
        performSegue(withIdentifier: SegueID.filter.id, sender: nil)
    }
    
    //MARK:- Actions
    @IBAction func onMapSW(_ sender: UIButtonDesignable) {
    }
    
    @IBAction func onList(_ sender: UIButtonDesignable) {
        containerListCafe.isHidden = false
    }
    
    @IBAction func filters(_ sender: UIButton){
        showFilters()
    }
    @IBAction func myLocationAction(_ sender: UIButtonDesignable) {
//        isMyLoc = !isMyLoc
//        if isMyLoc{
            sender.setImage(UIImage(named: "loc_red")!, for: .normal)
          isMyLoc = true
//            let scale = UIScreen.main.scale
//
            let locManager = getLocationManager()
            let manager = locManager?.location?.coordinate
            let z = self.mapView.mapWindow.map.cameraPosition.zoom
            mapView.mapWindow.map.move(with:
                YMKCameraPosition(target: YMKPoint(latitude: manager?.latitude ?? 55.7522200, longitude: manager?.longitude ?? 37.6155600), zoom: z, azimuth: 0, tilt: 0))
            
//            userLocationLayer?.setAnchorWithAnchorNormal(
//                CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
//                anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))

//        }else{
//            sender.setImage(UIImage(named: "loc_black")!, for: .normal)
//            userLocationLayer?.resetAnchor()
//        }
        
    }
    
    @IBAction func zoomPlusAction(_ sender: UIButtonDesignable) {
        zoom = self.mapView.mapWindow.map.cameraPosition.zoom
        zoom += 0.5
        let maxZoom = mapView.mapWindow.map.getMaxZoom()
        let pos = mapView.mapWindow.map.cameraPosition
        if zoom <= maxZoom{
            let position = YMKCameraPosition(target: pos.target, zoom: zoom, azimuth: 0, tilt: 0)
            mapView.mapWindow.map.move(with: position, animationType: YMKAnimation(type: .smooth, duration: 0.3), cameraCallback: nil)
        }else{
            zoom -= 0.5
        }
    }
    
    
    @IBAction func unZoomAction(_ sender: UIButtonDesignable) {
        zoom = self.mapView.mapWindow.map.cameraPosition.zoom
        zoom -= 0.5
        let minZoom = mapView.mapWindow.map.getMinZoom()
        let pos = mapView.mapWindow.map.cameraPosition
        if zoom >= minZoom{
            let position = YMKCameraPosition(target: pos.target, zoom: zoom, azimuth: 0, tilt: 0)
            mapView.mapWindow.map.move(with: position, animationType: YMKAnimation(type: .smooth, duration: 0.3), cameraCallback: nil)
        }else{
            zoom += 0.5
        }
    }
    
    
    //MARK:- deinit
    deinit{
        print("CafeViewController is deinit")
    }
    
}

//MARK:- CollectionView Cafe
extension CafeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeViewModel.numberOfRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.cafeCollection.identifire, for: indexPath) as! CafeCollectionViewCell
        cell.cafeData = cafeViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 96.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cafe = cafeViewModel.didSelectCafe(indexPath: indexPath)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SegueID.aboutCafe.id, sender: cafe)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/collectionView.bounds.width)
        if cafeViewModel.indexPath.row != Int(pageIndex){
            cafeViewModel.indexPath = IndexPath(row: Int(pageIndex), section: 0)
            createPlacemark(cafes: cafeViewModel.getFilterListCafe().value?.cafes ?? [])
            
            
            if cafeViewModel.indexPath.row < cafeViewModel.getFilterListCafe().value?.cafes?.count ?? 0{
                if let cafeLatStr = cafeViewModel.getFilterListCafe().value?.cafes?[cafeViewModel.indexPath.row].lat, let cafeLonStr = cafeViewModel.getFilterListCafe().value?.cafes?[cafeViewModel.indexPath.row].lng, let lat = Double(cafeLatStr), let lon = Double(cafeLonStr){
                    
                    let z = self.mapView.mapWindow.map.cameraPosition.zoom
                    isMyLoc = false
                    mapView.mapWindow.map.move(with:
                        YMKCameraPosition(target: YMKPoint(latitude: lat, longitude: lon), zoom: z, azimuth: 0, tilt: 0))
                    return
                }
            }
            
            let locManager = self.getLocationManager()
            let manager = locManager?.location?.coordinate
            
            myLocation.setImage(UIImage(named: "loc_red")!, for: .normal)
            let z = self.mapView.mapWindow.map.cameraPosition.zoom
            self.isMyLoc = true
            self.mapView.mapWindow.map.move(with:
                YMKCameraPosition(target: YMKPoint(latitude: manager?.latitude ?? 55.7522200, longitude: manager?.longitude ?? 37.6155600), zoom: z, azimuth: 0, tilt: 0))
        }
    }
}


//MARK:- MapKit
extension CafeViewController: YMKUserLocationObjectListener, YMKMapObjectTapListener, YMKMapCameraListener{
    
    func setupMyLocation(){
        
        myLocation.setImage(UIImage(named: "loc_black")!, for: .normal)
        
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.addCameraListener(with: self)
        
        let locManager = self.getLocationManager()
        let manager = locManager?.location?.coordinate
        self.isMyLoc = true
        self.mapView.mapWindow.map.move(with:
        YMKCameraPosition(target: YMKPoint(latitude: manager?.latitude ?? 55.7522200, longitude: manager?.longitude ?? 37.6155600), zoom: 14, azimuth: 0, tilt: 0))
        
        let mapKit = YMKMapKit.sharedInstance()!
        
        userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = true
        
        userLocationLayer?.setObjectListenerWith(self)
    }
    
    private func createPlacemark(cafes: [Cafe]){
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        for (i, cafe) in cafes.enumerated(){
            if let latStr = cafe.lat?.trimmingCharacters(in: .whitespacesAndNewlines), let lngStr = cafe.lng?.trimmingCharacters(in: .whitespacesAndNewlines), let lat = Double(latStr), let lng = Double(lngStr), let tOpen = cafe.open, let tClose = cafe.close{
                let point = YMKPoint(latitude: lat, longitude: lng)
                
                var isMark = false
                for place in placemarks{
                    if place.userData as? Int == cafe.id{
                        place.setIconWith(cafeViewModel.isOpenCafe(timeOpen: tOpen, timeClosed: tClose, index: i))
                        isMark = true
                        break
                    }
                }
                
                
                if isMark == false{
                    let placemark = mapObjects.addPlacemark(with: point)
                    placemark.userData = cafe.id
                    placemark.isDraggable = false
                    placemark.setIconWith(cafeViewModel.isOpenCafe(timeOpen: tOpen, timeClosed: tClose, index: i))
                    placemark.addTapListener(with: self)
                    placemarks.append(placemark)
                }
            }
        }
        
        var newPlacemarks = [YMKPlacemarkMapObject]()
        for place in placemarks{
            var isExist = false
            for cafe in cafes{
                if place.userData as? Int == cafe.id{
                    newPlacemarks.append(place)
                    isExist = true
                    break
                }
            }
            if isExist == false{
                mapObjects.remove(with: place)
            }
        }
        placemarks = newPlacemarks.filter({ (_) -> Bool in
            return true
        })
        
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let idCafe = mapObject.userData as? Int{
            if let indexPath = cafeViewModel.getIndexPath(at: idCafe){
                DispatchQueue.main.async {
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
        return true
    }
    
    
    func onObjectAdded(with view: YMKUserLocationView) {
    
        view.arrow.setIconWith(UIImage(named:"ArrowDirection")!)

        let pinPlacemark = view.pin.useCompositeIcon()
        pinPlacemark.setIconWithName(
            "pin",
            image: UIImage(named:"MyLoc")!,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 1,
                flat: true,
                visible: true,
                scale: 1.5,
                tappableArea: nil))

        view.accuracyCircle.fillColor = UIColor(named: "282A2F_10")!
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        print("update my position")
    }
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateSource: YMKCameraUpdateSource, finished: Bool) {
        if isMyLoc == false && myLocation.imageView?.image != UIImage(named: "loc_black")!{
            myLocation.setImage(UIImage(named: "loc_black")!, for: .normal)
        }else{
           isMyLoc = false
        }
    }
    
    

}

extension CafeViewController: CafeViewControllerDelegate{
    func logout() {
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            tabBarVC.removeDataAuth()
            tabBarVC.logout()
        }
    }
}
