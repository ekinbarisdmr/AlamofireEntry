//
//  EntryModel.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 14.05.2021.
//

import Foundation
import UIKit

struct Model: Decodable {
    var count: Int?
    var entries: [EntriesModel]?
}

struct EntriesModel: Decodable {
    
    var API: String?
    var Description: String?
    var Auth: String?
    var HTTPS: Bool?
    var Cors: String?
    var Link: String?
    var Category: String?
    
    init() {
        
    }
    
   
    
    init(API: String, Description: String, Auth: String, HTTPS: Bool, Cors: String, Link: String, Category: String) {
        
        
        self.API = API
        self.Description = Description
        self.Auth = Auth
        self.HTTPS = HTTPS
        self.Cors = Cors
        self.Link = Link
        self.Category = Category
        
    }
    
    
}
