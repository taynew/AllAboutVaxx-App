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
        title = "Vaccination Sites"
        
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
        Location(clinicName: "NYC Health + Hospitals/Gotham Health, Sydenham", address: "264 W 118th St, Manhattan, NY 10026", phoneNumber: "(844) 692-4692", website: "nychhc.org", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.8051471 , longitude: -73.9532666)),
        Location(clinicName: "Jamaica Hospital Medical Center", address: "8900 Van Wyck Expy, Queens, NY 11418", phoneNumber: "(718) 206-6000", website: "https://jamaicahospital.org/", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.700260 , longitude: -73.816223)),
         
        Location(clinicName: "New York Medical and Diagnostic Center", address: "80-46 Kew Gardens Rd, Kew Gardens, NY 11415", phoneNumber: "(718)  261-1000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.713110 , longitude: -73.830180)),
         
        Location(clinicName: "Columbia University Irving Medical Center", address: "622 W 168th St, New York, NY 10032", phoneNumber: "(877) 426-5637", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.840961 , longitude: -73.939468)),
         
        Location(clinicName: "NYU Langone Health", address: "550 1st Ave., New York, NY 10016", phoneNumber: "(646) 929-7800", website: "https://nyulangone.org/", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.742030 , longitude: -73.974350)),
         
        Location(clinicName: "SUNY Downstate Medical Center", address: "450 Clarkson Ave, Brooklyn, NY 11203", phoneNumber: "(718) 270-1000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.655930 , longitude: -73.941460)),
         
        Location(clinicName: "Midtown Health Center", address: "775 9th Ave, New York, NY 10019", phoneNumber: "(833) 386-3778", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.764620 , longitude: -73.988180)),
         
        Location(clinicName: "New York Preventive Health Center", address: "68-60 Austin Street Store 10, Forest Hills, NY 11375", phoneNumber: "(718) 997-7100", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.722010 , longitude: -73.850570)),
         
        Location(clinicName: "The Mount Sinai Hospital", address: "1468 Madison Ave, New York, NY 10029", phoneNumber: "(212) 241-6500", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.790310 , longitude:  -73.952103)),
         
        Location(clinicName: "Lenox Hill Hospital", address: "100 E 77th St, New York, NY 10075", phoneNumber: "(212) 434-2000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.773880 , longitude: -73.960777)),
         
        Location(clinicName: "Lincoln Medical Center", address: "234 E 149th St, Bronx, NY 10451", phoneNumber: "(718) 579-5000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.816971 , longitude: -73.92411)),
         
        Location(clinicName: "Montefiore Family Health Center", address: "1 Fordham Plaza, Bronx, NY 10458", phoneNumber: "(718) 933-2400", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.855820 , longitude: -73.92411)),
         
        Location(clinicName: "Interfaith Medical Center", address: "1545 Atlantic Ave, Brooklyn, NY 11213", phoneNumber: "(718) 613-4000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.678551 , longitude: -73.937424)),
         
        Location(clinicName: "Maimonides Medical Center", address: "4802 10th Ave, Brooklyn, NY 11219", phoneNumber: "(718) 283-6000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.639252 , longitude: -73.998169)),
         
        Location(clinicName: "American Medical Center", address: "434 Rockaway Ave, Brooklyn, NY 11212", phoneNumber: "(718) 346-2628", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.669280 , longitude: -73.910940)),
         
        Location(clinicName: "Kingsbrook Jewish Medical Center", address: "585 Schenectady Ave, Brooklyn, NY 11203", phoneNumber: "(718) 604-5000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.660019 , longitude: -73.932640)),
         
        Location(clinicName: "Brooklyn Health Center", address: "265 Ashland Pl, Brooklyn, NY 11217", phoneNumber: "(833) 386-3778", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.687400 , longitude: -73.978230)),
         
        Location(clinicName: "Calko Medical Center", address: "6010 Bay Pkwy, Brooklyn, NY 11204", phoneNumber: "(718) 234-6010", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.616570 , longitude: -73.979040)),
         
        Location(clinicName: "East Tremont Medical Center", address: "930 E Tremont Ave, Bronx, NY 10460", phoneNumber: "718) 223-4960", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.841350 , longitude: -73.883540)),
         
        Location(clinicName: "BronxCare Health and Wellness Center", address: "199 Mt Eden Pkwy, Bronx, NY 10457", phoneNumber: "(718) 590-1800", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.843300 , longitude: -73.909770)),
         
        Location(clinicName: "Boston Road Medical Center", address: "1262 Boston Rd, Bronx, NY 10456", phoneNumber: "(718) 617-2500", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.830420 , longitude:  -73.900660)),
         
        Location(clinicName: "Richmond University Medical Center", address: "355 Bard Ave, Staten Island, NY 10310", phoneNumber: "(718) 818-1234", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.635715 , longitude: -74.105980)),
         
        Location(clinicName: "Todt Hill Medical Center", address: "78 Todt Hill Rd, Staten Island, NY 10314", phoneNumber: "(718) 816-1952", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.611200  , longitude: -74.119500)),
         
        Location(clinicName: "Broadway Medical Center", address: "4446 Broadway, New York, NY 10040", phoneNumber: "(212) 567-6000", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.856270  , longitude: -73.93243)),
         
        Location(clinicName: "Manhattan Medical Health Care", address: "160 E 56th St 6th floor, New York, NY 10022", phoneNumber: "(212) 421-6509", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.762190  , longitude: -73.974330)),
         
        Location(clinicName: "Settlement Health", address: "212 E 106th St #1, New York, NY 10029", phoneNumber: "(212) 360-2600", website: "N/A", appointmentLink: "Call the clinic for an appointment.", coordinates: CLLocationCoordinate2D(latitude: 40.790871  , longitude: -73.944221))
        
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
