//
//  recordsViewController.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 4/5/22.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SafariServices

class recordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var docNameList = [recordsModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docNameList.count
    }
    
    
    @IBAction func reloadTapped(_ sender: Any) {
        self.recordsTable.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! vaccRecordTableViewCell
        let docu: recordsModel
        
        docu = docNameList[indexPath.row]
        
        cell.docName.text = docu.docName
        cell.date.text = docu.docDate
        cell.clinic.text = docu.docClinic
        cell.delete.tag = indexPath.row
        cell.delete.addTarget(self, action: #selector(deleteDoc), for: .touchUpInside)
        //if let url = URL(string: docu.docLink!)
               //{
                   //UIApplication.shared.open(url)
               //}
        return cell
    }
    
    @objc func deleteDoc(sender: UIButton) {
        let indexPath1 = IndexPath(row:sender.tag,section: 0)
        let selectedDocument = docNameList[indexPath1.row]
        let uid = Auth.auth().currentUser!.uid
        let docRef = Database.database().reference().child(uid)
        let photoRef = Storage.storage().reference().child("users").child(uid).child(selectedDocument.docName!)
        let alertController = UIAlertController(title: "Example", message: "Are you sure you want to delete the document?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            docRef.child(selectedDocument.docId!).setValue(nil)
            photoRef.delete { error in
              if let error = error {
                // Uh-oh, an error occurred!
              } else {
                // File deleted successfully
              }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(_) in
            return
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let docu: recordsModel
        docu = docNameList[indexPath.row]
        var linked = docu.docLink
        guard let url = URL(string: linked ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser!.uid
        let docRef = Database.database().reference().child(uid)
        navigationItem.title = "Vaccination Record"
        
        docRef.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.docNameList.removeAll()
                
                for docs in snapshot.children.allObjects as![DataSnapshot]{
                    let docObject = docs.value as? [String: AnyObject]
                    let DocumentID = docObject?["DocumentID"]
                    let NameofDocument = docObject?["NameofDocument"]
                    let Link = docObject?["Link"]
                    let Clinic = docObject?["Clinic"]
                    let Date = docObject?["Date"]
                    
                    let document = recordsModel(docId: DocumentID as! String?, docName: NameofDocument as! String?, docLink: Link as! String?, docDate: Date as! String?, docClinic: Clinic as! String?)
                    
                    self.docNameList.append(document)
                }
                
                self.recordsTable.reloadData()
            }
            
            
        })
        
    }
    
    @IBOutlet weak var recordsTable: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
}
