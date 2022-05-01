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

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var documentName: UITextField!
    
    
    @IBAction func uploadTapped(_ sender: Any) {
        PickImage()
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
        uploadStatus.text = "Upload Status: Complete!"
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
                    "NameofDocument": text,
                    "Link": urlString as! NSObject,
                    "DocumentID": key
                ]
                let datanode = dataref.child(uid).child(key!).setValue(fileData)
            })
        }
    }
}
