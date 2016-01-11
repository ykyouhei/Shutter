//
//  UploadViewController.swift
//  Shutter
//
//  Created by 千葉 俊輝 on 2016/01/11.
//  Copyright © 2016年 Koganepj. All rights reserved.
//

import UIKit
import Photos

internal final class UploadViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var cellSize: CGSize = CGSizeZero
    
    private var photoAssets: [PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavigation()
        setupCellSize()
        reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func reload() {
        setupPhotos()
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    private func setupNavigation() {
        let color = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.title = "Share"
    }
    
    private func setupCellSize() {
        let space: Int = 1 //マージン
        let spaceNum: Int = 2 //スペースの数
        let cellNum: Int = 3 //セルの数
        let screenSizeWidth = UIScreen.mainScreen().bounds.size.width
        let size = (screenSizeWidth - CGFloat(space * spaceNum)) / CGFloat(cellNum)
        self.cellSize = CGSizeMake(size, size)
    }
    
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
 
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAssets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
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
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.cellSize
    }
    
}
