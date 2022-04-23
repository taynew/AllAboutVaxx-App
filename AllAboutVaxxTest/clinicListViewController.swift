//
//  clinicListViewController.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 4/22/22.
//

import UIKit
import UIKit
import MapKit
import CoreLocation

class clinicListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var clinicTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clinicTable.dataSource = self
        clinicTable.delegate = self
    }
    
    struct Location {
        let clinicName: String
        let address: String
        let phoneNumber: String
        let website: String
        let appointmentLink: String
        let coordinates: CLLocationCoordinate2D
    }
    
    let data: [Location] = [
        Location(clinicName: "Elmhurst Hospital Center", address: "79-01 Broadway, Queens, NY 11373", phoneNumber: "+1 718 334 4000", website: "https://www.nychealthandhospitals.org/elmhurst", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude:40.744647 , longitude: -73.886196)),
        Location(clinicName: "Skycare Pharmacy", address: "85-29 Grand Avenue, Queens", phoneNumber: "(718) 685-2678", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude:40.735700 , longitude: -73.881430))
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = data[indexPath.row]
        let cell = clinicTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clinicCellTableViewCell
        cell.clinicName.text = location.clinicName
        cell.addressLabel.text = location.address
        cell.appointmentLabel.text = location.appointmentLink
        cell.phoneLabel.text = location.phoneNumber
        cell.websiteLabel.text = location.website
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = data[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "map") as? sourceToDestinationMapViewController
        vc?.destinationLocate = location.coordinates
        vc?.destinationNaming = location.clinicName
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
