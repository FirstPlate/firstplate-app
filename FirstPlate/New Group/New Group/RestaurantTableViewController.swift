//
//  RestaurantTableViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 21/06/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class RestaurantTableViewController: UITableViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    var viewModels = [RestaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up locationManager and begin location detection
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate {
            
            let locationDictionary : [String:Any] = ["latitude":coord.latitude,"longitude":coord.longitude]
            UserDefaults.standard.set(coord.latitude, forKey: "lat")
            UserDefaults.standard.set(coord.longitude, forKey: "lon")

        }
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
        
        let vm = viewModels[indexPath.row]
        cell.configure(with: vm)
        
        return cell
    }



}
