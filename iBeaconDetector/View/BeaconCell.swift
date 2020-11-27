//
//  BeaconCell.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 26.09.2020.
//

import UIKit

class BeaconCell: UITableViewCell {
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
}
