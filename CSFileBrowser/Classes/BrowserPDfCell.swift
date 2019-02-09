//
//  BrowserPDfCell.swift
//  BrowserDemo
//
//  Created by CoruscateMAC on 31/01/19.
//  Copyright © 2019 CoruscateMAC. All rights reserved.
//

import UIKit
import WebKit

class BrowserPDfCell: UICollectionViewCell,UIWebViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!

    override func awakeFromNib() {
        super.awakeFromNib()
        webView.delegate = self        
    }

    func setCellData(value : String){
        activityIndicator.startAnimating()
        
        if let url = URL(string : value){
            
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.webView.loadRequest(request)
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish to load")
        activityIndicator.stopAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Strat to load")
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()
    }
}
