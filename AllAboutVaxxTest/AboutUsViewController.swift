//
//  AboutUsViewController.swift
//  AllAboutVaxx
//
//  Created by Abir-Mac on 5/7/22.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    
    @IBOutlet weak var abirImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        abirImage.layer.cornerRadius = abirImage.frame.size.width / 2
        abirImage.clipsToBounds = true
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
