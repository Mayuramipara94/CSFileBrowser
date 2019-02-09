//
//  CSFileBrowser.swift
//  CSFileBrowser
//
//  Created by Coruscate on 09/02/19.
//

import UIKit

open class CSFileBrowser {
    
    public static func openAttachmentSlider(navigation : UINavigationController,attachment : [String]){
        
        let vc = BrowserVC.init(nibName: "BrowserVC", bundle: bundle)
        vc.attachments = attachment
        navigation.pushViewController(vc, animated: true)
        
    }
    
    static var bundle:Bundle {
        let podBundle = Bundle(for: CSFileBrowser.self)
        
        let bundleURL = podBundle.url(forResource: "CSFileBrowser", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
}
