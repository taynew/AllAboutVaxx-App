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
    
    init(docId:String?,docName:String?,docLink:String?){
        self.docId = docId;
        self.docName = docName;
        self.docLink = docLink;
    }
}
