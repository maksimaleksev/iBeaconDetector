//
//  ViewController.swift
//  iBeaconDetector
//
//  Created by Maxim Alekseev on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {
    
    private var locationManager = LocationManager()
    private var beacons: [Beacon] = []
    private var sortingOption: SortingOption = .rssi
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        initialInterfaceSetup()
    }
    
    //MARK: - VC Methods
    
    //Setup interface when first VC launch
    func initialInterfaceSetup() {
        tableView.tableFooterView = UIView()
        navigationItem.title = "iBeacons List"
    }
    
    //MARK: - IBActions
    @IBAction func segmentedControlHasSwitched(_ sender: UISegmentedControl) {
        
        switch sortingSegmentControl.selectedSegmentIndex {
        case 0:
            sortingOption = .rssi
        case 1:
            sortingOption = .distance
        default:
            print("There is no action for this selected segment")
        }
        
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortingOption.sortedBeacons(beacons).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell") as? BeaconCell else { fatalError("Cannot get BeaconCell") }
        
        let beacon = sortingOption.sortedBeacons(beacons)[indexPath.row]
        
        if beacon.rssi != 0 {
            cell.uuidLabel.text = "UUID: \(beacon.uuid)"
            cell.rssiLabel.text = "RSSI: \(beacon.rssi)"
            cell.distanceLabel.text = "Distance: \(String(format: "%.2f", beacon.distance)) m"
            cell.majorLabel.text = "Major: \(beacon.major)"
            cell.minorLabel.text = "Minor: \(beacon.minor)"
        } else {
            cell.uuidLabel.text = "UUID: \(beacon.uuid)"
            cell.rssiLabel.text = "RSSI: \(beacon.rssi)"
            cell.distanceLabel.text = "Distance: --"
            cell.majorLabel.text = "Major: \(beacon.major)"
            cell.minorLabel.text = "Minor: \(beacon.minor)"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = storyboard?.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        else { fatalError("Detail view controller has not found")}
        
        detailVC.beacon = beacons[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - LocationManagerDelegate

extension ViewController: LocationManagerDelegate {
    
    func setupBeacons(_ beacons: [Beacon]) {
        self.beacons = beacons
        tableView.reloadData()
    }
}
