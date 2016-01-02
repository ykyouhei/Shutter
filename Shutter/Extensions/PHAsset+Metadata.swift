//
//  PHAsset+Metadata.swift
//  Shutter
//
//  Created by 千葉 俊輝 on 2016/01/02.
//  Copyright © 2016年 Koganepj. All rights reserved.
//

import UIKit
import ImageIO
import Photos

extension PHAsset {

    typealias PHAssetMetadataBlock = ([String : AnyObject]) -> Void
    
    func requestMetadataWithCompletionBlock(completionBlock: PHAssetMetadataBlock) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        
            let editOptions = PHContentEditingInputRequestOptions()
            editOptions.networkAccessAllowed = true
            
            let _completionBlock = { (editingInput: PHContentEditingInput?, info: [NSObject : AnyObject]) -> Void in
                
                var image: CIImage?
                if let _editingInputURL = editingInput?.fullSizeImageURL {
                    image = CIImage(contentsOfURL: _editingInputURL)
                }
                
                var metaData: [String : AnyObject] = [:]
                if let _image = image {
                    metaData = _image.properties
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    completionBlock(metaData)
                })
            }
            
            self.requestContentEditingInputWithOptions(editOptions, completionHandler: _completionBlock)
        })
        
    }
}
