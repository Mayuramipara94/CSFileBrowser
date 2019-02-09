//
//  UIImageViewExtension.swift
//  KiranJewellery
//
//  Created by Rushi Sangani on 27/08/17.
//  Copyright © 2017 Rushi Sangani. All rights reserved.
//

import UIKit
import Foundation
import AVKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func dowloadFromServer(url: URL, completion : @escaping (() -> ())) {
        
        image = UIImage(named: "NoImageFound", in: CSFileBrowser.bundle, compatibleWith: nil)

        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                imageCache.setObject(image, forKey: url as AnyObject)
                self.image = image
                completion()
            }

            }.resume()
    }
    
    func setVideoThumb(url : URL,placeHolder : UIImage?, completion : @escaping (() -> ())) {
        self.image = UIImage(named: "NoImageFound", in: CSFileBrowser.bundle, compatibleWith: nil)

        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            completion()
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let asset: AVAsset = AVAsset(url: url)
            let duration  = asset.duration.seconds;
            let imageGenerator = AVAssetImageGenerator(asset: asset)

            do {
                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTime(seconds: Double(duration)/2, preferredTimescale: 60), actualTime: nil)

                DispatchQueue.main.async {
                    self.image = UIImage(cgImage: thumbnailImage)

                    if self.image == nil {
                        self.image = placeHolder
                    }
                    else {
                        imageCache.setObject(self.image!, forKey: url as AnyObject)
                    }
                    completion()
                }

            } catch let error {
                print(error)
            }
        }
    }
}
