//
//  SignUpViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 20/06/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?


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
    

    @IBAction func signup(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { authResult, error in
         
            guard let user = authResult?.user, error == nil else {
                
                
                if error == nil{
                  print("Successfully logging in")
                    
                }else{
                    print("Cannot Login")
                    print(error.debugDescription)
                    
                    let uialert = UIAlertController(title: "Cannot Login.", message: "Oops", preferredStyle: UIAlertController.Style.alert)
                       uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(uialert, animated: true, completion: nil)
                }
                
              return
            }
        }
    }
    
    //Registering the login listener
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
