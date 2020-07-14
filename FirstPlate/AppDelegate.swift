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
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // let window = UIWindow()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    var navigationController: UINavigationController?

    var handle: AuthStateDidChangeListenerHandle?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            print(Auth.auth().currentUser?.email)
            if Auth.auth().currentUser != nil {
                
                /*
                if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoodViewController") as? MoodViewController {
                    if let window = self.window, let rootViewController = window.rootViewController {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController {
                            currentController = presentedController
                        }
                        currentController.present(controller, animated: true, completion: nil)
                    }
                }
                */
 
                let nav = self.storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
                self.navigationController = nav
                self.window?.rootViewController = nav
                (nav?.topViewController as? RestaurantTableViewController)?.delegete = self
                
                
            } else {
                //User Not logged in
            }
        }

        var latitude = UserDefaults.standard.double(forKey: "lat")
        var longitude = UserDefaults.standard.double(forKey: "lon")
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        loadBusinesses(with: coordinate)

        
        return true
    }
    
    
    public func loadBusinesses(with coordinate: CLLocationCoordinate2D) {
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
    
    private func loadDetails(withId id: String) {
        service.request(.details(id:id)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else { return }
                if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data) {
                let detailsViewModel = DetailsViewModel(details: details)
                (strongSelf.navigationController?.topViewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                    
                } 
            case .failure(let error):
                print("Failed to get details \(error)")
            }
        }
    }


}

extension AppDelegate: ListActions {
    
    func didTapCell(viewModel: RestaurantListViewModel) {
        loadDetails(withId: viewModel.id)
    }
}


