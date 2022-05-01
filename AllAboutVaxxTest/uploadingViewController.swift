//
//  uploadingViewController.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 3/26/22.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class uploadingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vaccination Record"
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var documentName: UITextField!
    
    @IBOutlet weak var dateVaxx: UITextField!
    
    @IBOutlet weak var clinicVaxx: UITextField!
    
    let datePicker = UIDatePicker()
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        dateVaxx.inputAccessoryView = toolbar
        dateVaxx.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: -90, y: UIScreen.main.bounds.height - 50, width: self.view.frame.width, height: 200)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateVaxx.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func uploadTapped(_ sender: Any) {
        if (documentName.text?.isEmpty == true) {
            uploadStatus.text = "Upload Status: Please fill up document name field."
            return
        }
        PickImage()
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        if (documentName.text?.isEmpty == true) {
            uploadStatus.text = "Upload Status: Please fill up document name field."
            return
        }
        UseCamera()
    }
    
    @IBOutlet var uploadStatus: UILabel!
    
    
    @objc
    func PickImage()
    {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        //imagepicker.allowsEditing = false
            
        present(imagepicker, animated: true, completion: nil)
    }
    
    func UseCamera()
    {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .camera
        //imagepicker.allowsEditing = false
            
        present(imagepicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage
            {
                self.UploadImage(image: image)
                self.dismiss(animated: true, completion: nil)
            }
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
        
    func UploadImage(image: UIImage)
    {
        let uid = Auth.auth().currentUser!.uid;
        let storageref = Storage.storage().reference()
        let dataref = Database.database().reference()
        let text: String = documentName.text!
        let dates: String = "Date: " + dateVaxx.text!
        let clinics: String = "Clinic: " + clinicVaxx.text!
        var imageName = text + ".png"
        let imagenode = storageref.child("users").child(uid).child(imageName)
        
        let data = image.pngData()
        imagenode.putData(data!, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Error.")
                return
            }
            imagenode.downloadURL(completion: { (url,err) in
                if let err = err {
                    print("Error.")
                    return
                }
                guard let url = url else {
                    print("Error.")
                    return
                }
                let key = dataref.childByAutoId().key;
                let urlString = url.absoluteString
                let fileData: [String: Any] = [
                    "NameofDocument": imageName,
                    "Link": urlString as! NSObject,
                    "Date": dates,
                    "Clinic": clinics,
                    "DocumentID": key
                ]
                let datanode = dataref.child(uid).child(key!).setValue(fileData)
            })
        }
        uploadStatus.text = "Upload Status: Complete!"
        documentName.text?.removeAll()
        clinicVaxx.text?.removeAll()
        dateVaxx.text?.removeAll()
    }
}
