//
//  AboutUsViewController.swift
//  AllAboutVaxx
//
//  Created by Abir-Mac on 5/7/22.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    
    @IBOutlet weak var abirImage: UIImageView!
    @IBOutlet weak var derrickImage: UIImageView!
    @IBOutlet weak var kanizImage: UIImageView!
    @IBOutlet weak var haneulImage: UIImageView!
    @IBOutlet weak var sanzidaImage: UIImageView!
    @IBOutlet weak var pritomImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About Us"
        abirImage.layer.cornerRadius = abirImage.frame.size.width / 2
        abirImage.clipsToBounds = true
        derrickImage.layer.cornerRadius = derrickImage.frame.size.width / 2
        derrickImage.clipsToBounds = true
        kanizImage.layer.cornerRadius = kanizImage.frame.size.width / 2
        kanizImage.clipsToBounds = true
        haneulImage.layer.cornerRadius = haneulImage.frame.size.width / 2
        haneulImage.clipsToBounds = true
        sanzidaImage.layer.cornerRadius = sanzidaImage.frame.size.width / 2
        sanzidaImage.clipsToBounds = true
        pritomImage.layer.cornerRadius = pritomImage.frame.size.width / 2
        pritomImage.clipsToBounds = true
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
