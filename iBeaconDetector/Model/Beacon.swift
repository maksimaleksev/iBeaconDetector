//
//  Beacon.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 26.09.2020.
//

import Foundation

struct Beacon {
    
    var uuid: String
    var major: String
    var minor: String
    var rssi: Int
    var distance: Double
    
}


extension Beacon: Equatable {
        
    static func == (lhs: Beacon, rhs: Beacon) -> Bool {
            
        return lhs.uuid == rhs.uuid && lhs.minor == lhs.minor && lhs.major == rhs.major
        
    }

}
