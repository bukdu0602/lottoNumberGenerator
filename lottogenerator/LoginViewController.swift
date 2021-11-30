//
//  LoginViewController.swift
//  lottogenerator
//
//  Created by Ryan Lim on 2021-11-23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in if let e = error {
                print(e)
                self.errorMessage.text = e.localizedDescription
            } else{
                self.performSegue(withIdentifier: "loginToChoose", sender: self)
            }
          
          
        }}
    }
    
   

}
