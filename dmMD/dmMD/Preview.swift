//
//  Preview.swift
//  dmMD
//
//  Created by Siddharth on 19/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import AVFoundation

class Preview: UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
