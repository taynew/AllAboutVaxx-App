//
//  recordsModel.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 4/5/22.
//

import Foundation

class recordsModel {
    
    var docId: String?
    var docName: String?
    var docLink: String?
    var docDate: String?
    var docClinic: String?
    
    init(docId:String?,docName:String?,docLink:String?, docDate:String?, docClinic:String?){
        self.docId = docId;
        self.docName = docName;
        self.docLink = docLink;
        self.docDate = docDate;
        self.docClinic = docClinic
    }
}
