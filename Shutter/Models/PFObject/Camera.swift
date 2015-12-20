//
//  Camera.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/20.
//  Copyright © 2015年 Koganepj. All rights reserved.
//

import Parse
import Bolts

/// カメラの種別を表すオブジェクト。サーバ側で登録するのでアプリでは使うだけ
public final class Camera: PFObject  {
    
    //========================================================================//
    // MARK: - Properties
    //========================================================================//
    
    /// カメラのモデル名
    @NSManaged var model: String
    
    /// カメラのメーカー名
    @NSManaged var make: String
    
    /// カメラの画像ファイル
    @NSManaged var imageFie: PFFile
    
    /// Amazonの商品リンク
    @NSManaged var amazonLink: String
    
    
    //========================================================================//
    // MARK: - Public Method
    //========================================================================//
    
    /**
    すべてのCameraオブジェクトを取得する。Parseのlimitがmax1000なので1000件以上になる場合は改良する
    
    - returns: BFTask<[Camera]>
    */
    static public func findAllCameraInBackground() -> BFTask {
        let query = Camera.query()!
        
        query.limit = 1000
       
        return query.findObjectsInBackground()
    }

}


extension Camera: PFSubclassing {
    
    override public class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    public static func parseClassName() -> String {
        return "Camera"
    }
    
}
