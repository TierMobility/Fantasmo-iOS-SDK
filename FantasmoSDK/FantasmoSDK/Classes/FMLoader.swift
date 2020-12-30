//
//  Loader.swift
//  FantasmoSDK
//
//  Copyright © 2020 Fantasmo. All rights reserved.
//

import Foundation
import CoreLocation
import ARKit
import CocoaLumberjack

public class FMLoader: NSObject {
    /**
     Loader method for initialize swizzle method.
     */
    @objc public static func swiftyLoad() {
        DDLogInfo("Fantasmo SDK loaded")
        
        CLLocationManager.swizzle()
        ARSession.swizzle()
    }
}