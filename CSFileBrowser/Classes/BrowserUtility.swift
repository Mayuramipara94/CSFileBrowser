//
//  BrowserUtility.swift
//  BrowserDemo
//
//  Created by CoruscateMAC on 31/01/19.
//  Copyright © 2019 CoruscateMAC. All rights reserved.
//

import UIKit

class BrowserUtility: NSObject {

    class func checkDocumentTypo(urlStr : String) -> Int{
        
        let value = urlStr.lowercased()
        if value.contains(".png") || value.contains(".jpg") || value.contains(".jpeg"){
            return BrowserConstants.AttachmentType.image
        }else if value.contains(".doc") || value.contains(".docx") || value.contains(".xlsx") || value.contains(".xls") || value.contains(".pdf") || value.contains(".txt") || value.contains(".ppt") || value.contains(".pptx") || value.contains(".xls"){
            return BrowserConstants.AttachmentType.document
            
        }else if value.contains(".webm") || value.contains(".mkv") || value.contains(".m4v") || value.contains(".3gp") || value.contains(".mp4") || value.contains(".mov"){
            return BrowserConstants.AttachmentType.video
            
        }else if value.contains(".m4a") || value.contains(".m4b") || value.contains(".m4p") || value.contains(".mp3") || value.contains(".wav") || value.contains(".webm") {
            return BrowserConstants.AttachmentType.audio
        }
        
        return BrowserConstants.AttachmentType.undefined
    }
    
    class func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func isFileExists(path:String) -> Bool{
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            return true
        }else{
            return false
        }
    }
}

