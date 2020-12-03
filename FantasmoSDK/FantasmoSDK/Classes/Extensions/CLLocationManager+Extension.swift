//
//  CoreLocation+Extension.swift
//  FantasmoSDK
//
//  Created by Ryan on 10/1/20.
//

import CoreLocation
import CocoaLumberjack

extension CLLocationManager : CLLocationManagerDelegate {
    
    private struct AssociatedKeys {
        static var delegateState: UInt8 = 0
    }
    
    public private(set) static var lastLocation: CLLocation?
    
    /**
     Intercept delegate method for execute delegate.
     
     - Parameter delegate: Delegate of CLLocation .
     */
    @objc func interceptedDelegate(delegate : Any) {
        objc_setAssociatedObject(self, &AssociatedKeys.delegateState, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.interceptedDelegate(delegate: self)
    }
    
    /**
     Swizzle method for exchange swizzled and original methods
     */
    static func swizzle() {
        let _: () = {
            let originalSelector = #selector(setter: CLLocationManager.delegate)
            let swizzledSelector = #selector(CLLocationManager.interceptedDelegate(delegate:))
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            method_exchangeImplementations (originalMethod!, swizzledMethod!)
            DDLogVerbose("CLLocationManager:swizzle")
        }()
    }
    
    /**
     invoked when new locations are available.  Required for delivery of deferred locations.

     @param manager Currnet location manager.
     @param locations An array of CLLocation objects in chronological order.
     */
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLLocationManager.lastLocation = locations.last
        guard let delegate = objc_getAssociatedObject(self, &AssociatedKeys.delegateState) as? CLLocationManagerDelegate else {
            DDLogWarn("CLLocationManager:swizzle didUpdateLocations delegate not available")
            return
        }
        delegate.locationManager?(manager, didUpdateLocations: locations)
        DDLogVerbose("CLLocationManager:swizzle didUpdateLocations")
    }
    
    /**
     invoked when new headings are available.  Required for delivery of deferred headings.

     @param manager Currnet location manager.
     @param heading CLHeading object with updated heading.
     */
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        guard let delegate = objc_getAssociatedObject(self, &AssociatedKeys.delegateState) as? CLLocationManagerDelegate else {
            DDLogWarn("CLLocationManager:swizzle didUpdateHeading delegate not available")
          return
        }
        delegate.locationManager?(manager, didUpdateHeading: heading)
        DDLogVerbose("CLLocationManager:swizzle didUpdateHeading")
    }
}

