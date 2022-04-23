//
//  clinicListViewController.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 4/22/22.
//

import UIKit
import MapKit
import CoreLocation


class clinicListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var clinicTable: UITableView!
    
    @IBOutlet weak var sortPressed: UIButton!
    
    
    @IBAction func sortByLocationPressed(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clinicTable.dataSource = self
        clinicTable.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    struct Location {
        let clinicName: String
        let address: String
        let phoneNumber: String
        let website: String
        let appointmentLink: String
        let coordinates: CLLocationCoordinate2D
    }
    
    var data: [Location] = [
        Location(clinicName: "Elmhurst Hospital Center", address: "79-01 Broadway, Queens, NY 11373", phoneNumber: "+1 718 334 4000", website: "https://www.nychealthandhospitals.org/elmhurst", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude:40.744647 , longitude: -73.886196)),
        Location(clinicName: "Skycare Pharmacy", address: "85-29 Grand Avenue, Queens", phoneNumber: "(718) 685-2678", website: "N/A", appointmentLink: "Call the pharmacy for an appointment.", coordinates: CLLocationCoordinate2D(latitude:40.735700 , longitude: -73.881430)),
        Location(clinicName: "Queens Hospital Center", address: "82-68 164th St, Queens, NY 11432", phoneNumber: "(718) 883-3000", website: "https://www.nychealthandhospitals.org/queens/", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.7172699 , longitude: -73.8043545)),
        Location(clinicName: "Estates Pharmacy & Surgical", address: "169-01 Hillside Avenue, Queens, NY 11432", phoneNumber: "(718) 739-0311", website: "https://www.estatespharmacy.com/", appointmentLink: "Call the pharmacy for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.711130 , longitude: -73.792680)),
        Location(clinicName: "Harlem United's The Nest Community Health Center", address: "169 W 133rd St, New York, NY 10030", phoneNumber: "(646) 762-4950", website: "https://www.harlemunited.org/the-nest-is-now-open/", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.813961 , longitude: -73.943909)),
        Location(clinicName: "NYC Health + Hospitals/Gotham Health, Sydenham", address: "264 W 118th St, Manhattan, NY 10026", phoneNumber: "(844) 692-4692", website: "nychhc.org", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.8051471 , longitude: -73.9532666))
        
    ]
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        var userl = MKMapPoint.init(locValue)
        self.data.sort(by:{userl.distance(to: MKMapPoint.init($0.coordinates))<userl.distance(to: MKMapPoint.init($1.coordinates))})
        clinicTable.reloadData()
    }
    
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
