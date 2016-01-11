//
//  UploadViewController.swift
//  Shutter
//
//  Created by 千葉 俊輝 on 2016/01/11.
//  Copyright © 2016年 Koganepj. All rights reserved.
//

import UIKit
import Photos

internal final class UploadViewController: UIViewController {
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    /// 一行に表示するセルの数
    private let layoutInfo = (numberOfCellsPerRow: 3, cellSpace: CGFloat(1))
    
    private var photoAssets: [PHAsset] = []
    
    
    /* ====================================================================== */
    // MARK: - Outlets
    /* ====================================================================== */
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    /* ====================================================================== */
    // MARK: - View Life Cycle
    /* ====================================================================== */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Upload.Label.Title", comment: "")
        
        setupCellSize()
        reload()
    }
    
    private func reload() {
        setupPhotos()
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    private func setupCellSize() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let spaceNum = CGFloat(layoutInfo.numberOfCellsPerRow - 1)
        let screenSizeWidth = UIScreen.mainScreen().bounds.size.width
        let size = (screenSizeWidth - CGFloat(layoutInfo.cellSpace * spaceNum)) / CGFloat(layoutInfo.numberOfCellsPerRow)
        
        flowLayout.itemSize = CGSize(width: size, height: size)
    }
    
    // TODO: Managerクラスに分ける
    // MARK: Photos Framework
    private func setupPhotos() {
        
        if authorizationCheck() == false {
            // 設定画面に遷移
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
            
            return
        }
        
        self.photoAssets = []
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        PHAsset.fetchAssetsWithMediaType(.Image, options: options).enumerateObjectsUsingBlock({
        (asset, index, stop) -> Void in
            if let _asset = asset as? PHAsset {
                self.photoAssets.append(_asset)
            }
        })
    }
    
    private func authorizationCheck() -> Bool {
        var authorize: Bool = false
        switch PHPhotoLibrary.authorizationStatus() {
        case .NotDetermined, .Restricted, .Denied:
            authorize = false
            break
        case .Authorized:
            authorize = true
            break
        }
        
        return authorize
    }
 
}


// MARK: - UICollectionViewDataSource
extension UploadViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAssets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            R.reuseIdentifier.cell.identifier,
            forIndexPath: indexPath)
        
        let asset = self.photoAssets[indexPath.row]
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            let scale = UIScreen.mainScreen().scale
            let imageSize = CGSizeMake(imageView.frame.size.width * scale, imageView.frame.size.height * scale)
            PHImageManager().requestImageForAsset(asset, targetSize: imageSize, contentMode: .AspectFill, options: nil, resultHandler: {(image, info) -> Void in
                imageView.image = image
            })
        }
        
        return cell
    }
    
}
