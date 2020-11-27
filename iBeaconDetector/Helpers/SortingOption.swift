//
//  SortingOption.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 26.09.2020.
//

import Foundation

enum SortingOption {
    case rssi
    case distance
}


extension SortingOption {
    
    //Sorting beacons
    
    func sortedBeacons(_ beacons: [Beacon]) -> [Beacon] {
        
        switch self {
        case .rssi:
            return beacons.sorted { $0.rssi > $1.rssi }
        case .distance:
            return beacons.sorted { $0.distance < $1.distance }
        }
    }
}
