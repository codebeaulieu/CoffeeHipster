//
//  Extension+UIImageView.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            Alamofire.request(.GET, url).response { response in
                let data = response.2
                self.image = UIImage(data: data!, scale:1)
            } 
        }
    }
}
