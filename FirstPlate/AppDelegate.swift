//
//  AppDelegate.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 25/05/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // let window = UIWindow()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    var navigationController: UINavigationController?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
        window?.rootViewController = nav
        var latitude = UserDefaults.standard.double(forKey: "lat")
        var longitude = UserDefaults.standard.double(forKey: "lon")
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        loadBusinesses(with: coordinate)
        
        return true
    }
    
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init).sorted(by: { $0.distance < $1.distance })
                if let nav = strongSelf.window?.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }


}

