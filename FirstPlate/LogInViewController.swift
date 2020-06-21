//
//  LogInViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 20/06/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?


    @IBOutlet var EmailTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBAction func LogInButtonClicked(_ sender: Any) {
        
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
           
            if error != nil{
                print(error.debugDescription)
                print("CaNNOT LOGIN")
                
                let uialert = UIAlertController(title: "Cannot Login. Check your password.", message: "Oops", preferredStyle: UIAlertController.Style.alert)
                   uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self!.present(uialert, animated: true, completion: nil)
            }
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
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
