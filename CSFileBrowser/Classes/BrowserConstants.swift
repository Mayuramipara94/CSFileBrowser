//
//  BrowserConstants.swift
//  BrowserDemo
//
//  Created by CoruscateMAC on 31/01/19.
//  Copyright © 2019 CoruscateMAC. All rights reserved.
//

import UIKit

class BrowserConstants: NSObject {
    
    //MARK: Attachment type
    struct AttachmentType{
        static let image               = 1
        static let video               = 2
        static let document            = 3
        static let audio               = 4
        static let undefined           = 5
    }
}

class BrowserModel : NSObject{
    
    var strURL : String?
    var cellType : BrowserCellTypes?
}


extension UIViewController {
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar || false
    }
}

extension String {
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
