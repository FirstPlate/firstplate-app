//
//  ViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 25/05/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "showScreen", sender: UIButton.self)
            } else {
                //User Not logged in
            }
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }



}

