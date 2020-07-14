//
//  ProfileViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 13/07/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var confirmationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationLabel.text = ""
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            
            emailTextField.text = email
        // Do any additional setup after loading the view.
    }
        
    }
    
        
    @IBAction func saveClick(_ sender: Any) {
        confirmationLabel.text = "Profile saved successfully."
    }
    
    // Closes keyboard when screen tapped outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    // Closes keyboard when 'Return' key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        confirmationLabel.text = ""
    }

    @IBAction func logOutClick(_ sender: Any) {
        
        print("logged out")
        try! Auth.auth().signOut()

    }
    

    
}
