//
//  ViewController.swift
//  CSFileBrowser
//
//  Created by Mayuramipara94 on 02/09/2019.
//  Copyright (c) 2019 Mayuramipara94. All rights reserved.
//

import UIKit
import CSFileBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var attachments = ["https://www.gstatic.com/webp/gallery/1.jpg",
                               "https://www.gstatic.com/webp/gallery/2.jpg",
                               "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                               "https://www.gstatic.com/webp/gallery/4.jpg",
                               "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                               "http://www.pdf995.com/samples/pdf.pdf",
                               "https://www.gstatic.com/webp/gallery/5.jpg",
                               "http://techslides.com/demos/sample-videos/small.mp4",
                               "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
                               "https://easychair.org/publications/easychair.docx",
                               "http://www.africau.edu/images/default/sample.pdf"]
        
        if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            for document in listFilesFromDocumentsFolder() ?? []{
                attachments.append(documentsPathURL.appendingPathComponent("/\(document)").path)
            }
        }
        
        CSFileBrowser.openAttachmentSlider(navigation: self.navigationController!, attachment: attachments)
    }
    
    func listFilesFromDocumentsFolder() -> [String]?
    {
        let fileMngr = FileManager.default;
        
        // Full path to documents directory
        let docs = fileMngr.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        
        // List all contents of directory and return as [String] OR nil if failed
        return try? fileMngr.contentsOfDirectory(atPath:docs)
    }

}

