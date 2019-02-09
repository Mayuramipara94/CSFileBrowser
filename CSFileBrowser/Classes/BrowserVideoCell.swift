//
//  BrowserVideoCell.swift
//  BrowserDemo
//
//  Created by CoruscateMAC on 31/01/19.
//  Copyright © 2019 CoruscateMAC. All rights reserved.
//

import UIKit
import AVKit

class BrowserVideoCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setCellData(value : String){
        if let url = URL(string: value), value.isValidURL{
            activityIndicator.startAnimating()
            imgView.setVideoThumb(url: url, placeHolder: UIImage(named: "NoImageFound", in: CSFileBrowser.bundle, compatibleWith: nil)) {
                self.activityIndicator.stopAnimating()
            }
            
        }else if BrowserUtility.isFileExists(path: value) {
            
            activityIndicator.startAnimating()
            imgView.setVideoThumb(url: URL(fileURLWithPath: value), placeHolder: UIImage(named: "NoImageFound", in: CSFileBrowser.bundle, compatibleWith: nil)) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setAudioCellData(value : String){
        DispatchQueue.main.async {
            self.imgView.image = UIImage(named: "speaker", in: CSFileBrowser.bundle, compatibleWith: nil)
        }
    }
}


