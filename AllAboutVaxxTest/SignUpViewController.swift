//
//  SignUpViewController.swift
//  AllAboutVaxxTest
//
//  Created by Derrick Duller on 3/9/22.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBAction func signUpTapped(_ sender: Any) {
        if (email.text?.isEmpty == true) {
            print("No text in email field.")
            return
        }
        
        if (password.text?.isEmpty == true) {
            print("No text in password field.")
            return
        }
        
        signUP()
    }
    
    func signUP() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let alert = UIAlertController(title: "Confirmation", message: "Your account has been created.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
