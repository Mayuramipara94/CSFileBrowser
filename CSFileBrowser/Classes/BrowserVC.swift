//
//  OrderDetailVC.swift
//  eRxPharmacy
//
//  Created by Vish on 22/12/18.
//  Copyright © 2018 Vish. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

enum BrowserCellTypes{
    case ImageCell
    case VideoCell
    case DocumentCell
    case AudioCell
}

class BrowserVC: UIViewController {
    
    //MARK: variables
    var attachments = [String]()
    var navigationTitle : String = "Preview"
    private var currentIndex = 1
    private var arrBrowserModel = [BrowserModel]()
    
    //MARK: Outlets
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var collectionViewlayout: UICollectionViewFlowLayout!
    
    //MARK: View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK: Initial config
    func initialConfig(){
    
        self.title = navigationTitle
        collView.register(UINib(nibName: "BrowserAudioCell", bundle: CSFileBrowser.bundle), forCellWithReuseIdentifier: "BrowserAudioCell")
        collView.register(UINib(nibName: "BrowserDetailCell", bundle: CSFileBrowser.bundle), forCellWithReuseIdentifier: "BrowserDetailCell")
        collView.register(UINib(nibName: "BrowserPDfCell", bundle: CSFileBrowser.bundle), forCellWithReuseIdentifier: "BrowserPDfCell")
        collView.register(UINib(nibName: "BrowserVideoCell", bundle: CSFileBrowser.bundle), forCellWithReuseIdentifier: "BrowserVideoCell")

        lblTotalCount.text = "\(currentIndex) / \(attachments.count)"
        prepareDataSource()
        
        if attachments.count == 0 {
            lblTotalCount.isHidden = true
        }
    }
    
    //MARK: PrepareDataSource
    func prepareDataSource(){
        
        arrBrowserModel.removeAll()
        
        for item in attachments{
            
            if BrowserUtility.checkDocumentTypo(urlStr: item) == BrowserConstants.AttachmentType.video{
                
                appendCell(value: item, cellType: .VideoCell)
                
            }else if BrowserUtility.checkDocumentTypo(urlStr: item) == BrowserConstants.AttachmentType.image{
                
                appendCell(value: item, cellType: .ImageCell)

            }else if BrowserUtility.checkDocumentTypo(urlStr: item) == BrowserConstants.AttachmentType.document{

                appendCell(value: item, cellType: .DocumentCell)

            }else if BrowserUtility.checkDocumentTypo(urlStr: item) == BrowserConstants.AttachmentType.audio{
                
                appendCell(value: item, cellType: .AudioCell)
                
            }
        }
        
        collView.reloadData()
    }
    
    //MARK: private methods
    func appendCell(value : String, cellType : BrowserCellTypes){
        let model = BrowserModel()
        model.strURL = value
        model.cellType = cellType
        
        arrBrowserModel.append(model)
    }
    
    //MARK: Button action methods
    @IBAction func btnClose_click(_ sender: Any) {
        if self.isModal {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: Collectionview delegate methods
extension BrowserVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBrowserModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = arrBrowserModel[indexPath.row]
        
        if model.cellType == .ImageCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserDetailCell", for: indexPath) as! BrowserDetailCell
            cell.setCellData(value: model.strURL ?? "")

            return cell
            
        }else if model.cellType == .VideoCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserVideoCell", for: indexPath) as! BrowserVideoCell
            cell.setCellData(value: model.strURL ?? "")
            cell.btnPlay.tag = indexPath.row
            cell.btnPlay.addTarget(self, action: #selector(btnPlay_Click), for: .touchUpInside)
            return cell
            
        }else if model.cellType == .DocumentCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserPDfCell", for: indexPath) as! BrowserPDfCell
            cell.setCellData(value: model.strURL ?? "")
            
            return cell
            
        }else if model.cellType == .AudioCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserVideoCell", for: indexPath) as! BrowserVideoCell
            cell.setAudioCellData(value: model.strURL ?? "")
            cell.btnPlay.tag = indexPath.row
            cell.btnPlay.addTarget(self, action: #selector(btnPlay_Click), for: .touchUpInside)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height)
    }
    
    @IBAction func btnPlay_Click(_ sender : UIButton){
        
        let model = arrBrowserModel[sender.tag]

        if let videoURL = URL(string: model.strURL ?? ""), (model.strURL ?? "").isValidURL{
            
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.showsPlaybackControls = true
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
        }else if BrowserUtility.isFileExists(path: model.strURL ?? ""){
            
            let player = AVPlayer(url: URL(fileURLWithPath: model.strURL ?? ""))
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.showsPlaybackControls = true
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collView.contentOffset
        visibleRect.size = collView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = collView.indexPathForItem(at: visiblePoint) else { return }
        
        currentIndex = indexPath.row
        lblTotalCount.text = "\(indexPath.row + 1) / \(attachments.count)"
    }
}
