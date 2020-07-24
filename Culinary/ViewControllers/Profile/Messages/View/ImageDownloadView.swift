//
//  ImageDownloadView.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class ImageDownloadView: UIView {

    @IBOutlet weak var img: UIImageViewDesignable!
    @IBOutlet weak var nameImg: UILabel!
    @IBOutlet weak var sizeImage: UILabel!
    
    
    weak var dataImage: ImageDownloadViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.img ?? ""))
            nameImg.text = data?.name
            sizeImage.text = data?.titleSize
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        img.sd_setImage(with: url, placeholderImage: nil, completed: nil)
    }
    
    deinit {
        print("ImageDownloadView is deinit")
    }
}
