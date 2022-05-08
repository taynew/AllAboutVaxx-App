//
//  passwordResetViewController.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 5/6/22.
//

import UIKit
import Firebase
import FirebaseAuth


class passwordResetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        title = "Password Reset"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailAddress: UITextField!
    
    
    @IBAction func sendEmailTaped(_ sender: Any) {
        if (emailAddress.text?.isEmpty == true) {
            print("No text in email field.")
            return
        }
        
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailAddress.text!){ (error) in
            if let error = error {
                print("Error")
                return
            }
        }
        let alert = UIAlertController(title: "Confirmation", message: "Your password reset email has been sent.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
