//
//  InformationViewController.swift
//  AllAboutVaxx
//
//  Created by Abir-Mac on 4/30/22.
//

import UIKit
import Firebase
import FirebaseAuth

class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LogoutTapped(_ sender: Any) {
        let auth = Auth.auth()
        do{
            try auth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError{
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
