//
//  SignUpViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 20/06/20.
//  Copyright © 2020 FirstPlate. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var NameField: UITextField!
    
    @IBOutlet var EmailField: UITextField!
    
    @IBOutlet var PasswordField: UITextField!
    
    @IBAction func SignUpClicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

}
