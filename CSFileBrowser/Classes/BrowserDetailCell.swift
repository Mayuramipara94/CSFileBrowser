//
//  OrderDetailCell.swift
//  eRxPharmacy
//
//  Created by Vish on 22/12/18.
//  Copyright © 2018 Vish. All rights reserved.
//

import UIKit

class BrowserDetailCell: UICollectionViewCell{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var imageConstraintRight: NSLayoutConstraint!
    @IBOutlet weak var imageConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak var imageConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var lastZoomScale: CGFloat = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
        addDoubleTapGesture()
        activityIndicator.isHidden = true
        imgView.contentMode = .scaleAspectFit

    }
    
    //MARK: Add double tap gesture
    func addDoubleTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gesture))
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func gesture(_ gesture : UITapGestureRecognizer){
        
        if scrollView.zoomScale == 1.0{
            scrollView.zoomScale = 3.0
        }else{
            scrollView.zoomScale = 1.0
        }
        
    }
    
    //MARK: set cellData
    func setCellData(value : String){
        
        if let url = URL(string: value), value.isValidURL{
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                self.imgView.dowloadFromServer(url: url) {
                    self.activityIndicator.stopAnimating()
                }
            }
           
        }else if BrowserUtility.isFileExists(path: value) == true{
            
            imgView.image = UIImage(contentsOfFile: value)
        }else{
            imgView.image = UIImage(named: "NoImageFound", in: CSFileBrowser.bundle, compatibleWith: nil)
        }
    }
    
}

//MARK: Scrollview delegate methods
extension BrowserDetailCell: UIScrollViewDelegate {
    
    //MARK: Override constrait delegate method for cell
    override func updateConstraintsIfNeeded() {
        if let image = imgView.image {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            let viewWidth = scrollView.bounds.size.width
            let viewHeight = scrollView.bounds.size.height
            
            // center image if it is smaller than the scroll view
            var hPadding = (viewWidth - scrollView.zoomScale * imageWidth) / 2
            if hPadding < 0 { hPadding = 0 }
            
            var vPadding = (viewHeight - scrollView.zoomScale * imageHeight) / 2
            if vPadding < 0 { vPadding = 0 }
            
            imageConstraintLeft.constant = hPadding
            imageConstraintRight.constant = hPadding
            
            imageConstraintTop.constant = vPadding
            imageConstraintBottom.constant = vPadding
            imgView.center = scrollView.center;
            self.layoutIfNeeded()
        }
    }
    
    // Zoom to show as much image as possible unless image is smaller than the scroll view
    func updateZoom() {
        print(scrollView.zoomScale)
        
        if let image = imgView.image {
            var minZoom = min(scrollView.bounds.size.width / image.size.width,
                              scrollView.bounds.size.height / image.size.height)
            
            if minZoom > 1 { minZoom = 1 }
            
            scrollView.minimumZoomScale = 0.3 * minZoom
            
            // Force scrollViewDidZoom fire if zoom did not change
            if minZoom == lastZoomScale { minZoom += 0.000001 }
            
            scrollView.zoomScale = minZoom
            lastZoomScale = minZoom
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
}
