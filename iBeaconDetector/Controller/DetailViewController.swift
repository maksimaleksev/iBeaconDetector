//
//  DetailViewController.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 28.09.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var locationmanager = LocationManager()
    var beacon: Beacon!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    
    //MARK: - VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager.delegate = self
        initialInterfaceSetup()
    }
    
    //MARK: - VC Methods
    
    //Setup interface 
    
    func initialInterfaceSetup() {
        
        if beacon.rssi != 0 {
            uuidLabel.text = "UUID: \(beacon.uuid)"
            rssiLabel.text = "RSSI: \(beacon.rssi)"
            distanceLabel.text = "Distance: \(String(format: "%.2f", beacon.distance)) m"
            majorLabel.text = "Major: \(beacon.major)"
            minorLabel.text = "Minor: \(beacon.minor)"
        } else {
            uuidLabel.text = "UUID: \(beacon.uuid)"
            rssiLabel.text = "RSSI: \(beacon.rssi)"
            distanceLabel.text = "Distance: --"
            majorLabel.text = "Major: \(beacon.major)"
            minorLabel.text = "Minor: \(beacon.minor)"
        }
    }
}


//MARK: - LocationManagerDelegate methods

extension DetailViewController: LocationManagerDelegate {
    
    func setupBeacons(_ beacons: [Beacon]) {
        
        for beacon in beacons {
            
            if beacon == self.beacon {
                self.beacon = beacon
                initialInterfaceSetup()
                break
            }
        }
        
    }
    
}
