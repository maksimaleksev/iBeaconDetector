//
//  LocationManager.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 26.09.2020.
//

import CoreLocation

protocol LocationManagerDelegate: class  {
    func setupBeacons(_ beacons: [Beacon])
}

class LocationManager: NSObject  {
    
    weak var delegate: LocationManagerDelegate?
    
   private var clLocationManager = CLLocationManager()
    
    private let uuidString = "A2FA7357-C8CD-4B95-98FD-9D091CE43337"
    private let identifier = "MyBeacon"
    
    override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.requestAlwaysAuthorization()
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: uuidString)!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 10, minor: 20, identifier: identifier)
        let constraint = CLBeaconIdentityConstraint(uuid: uuid)
        clLocationManager.startMonitoring(for: beaconRegion)
        clLocationManager.startRangingBeacons(satisfying: constraint)
    }
    
}


//MARK: - CLLocationManagerDelegate methods

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        let gettedBeacons = beacons.map({ (clBeacon) -> Beacon in
            
            return Beacon(uuid: clBeacon.uuid.uuidString,
                          major: clBeacon.major.stringValue,
                          minor: clBeacon.minor.stringValue,
                          rssi: clBeacon.rssi,
                          distance: clBeacon.accuracy)
            
        })
        
        delegate?.setupBeacons(gettedBeacons)
    }
    
}
