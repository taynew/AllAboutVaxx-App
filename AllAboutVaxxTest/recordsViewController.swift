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
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! vaccRecordTableViewCell
        let docu: recordsModel
        
        docu = docNameList[indexPath.row]
        
        cell.docName.text = docu.docName
        //if let url = URL(string: docu.docLink!)
               //{
                   //UIApplication.shared.open(url)
               //}
        return cell
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
        
        docRef.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.docNameList.removeAll()
                
                for docs in snapshot.children.allObjects as![DataSnapshot]{
                    let docObject = docs.value as? [String: AnyObject]
                    let DocumentID = docObject?["DocumentID"]
                    let NameofDocument = docObject?["NameofDocument"]
                    let Link = docObject?["Link"]
                    
                    let document = recordsModel(docId: DocumentID as! String?, docName: NameofDocument as! String?, docLink: Link as! String?)
                    
                    self.docNameList.append(document)
                }
                
                self.recordsTable.reloadData()
            }
            
            
        })
        
    }
    
    @IBOutlet weak var recordsTable: UITableView!
    
}
