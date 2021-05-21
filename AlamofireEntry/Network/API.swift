//
//  API.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 14.05.2021.
//

import Foundation
import Alamofire

class API {
    
    static let sharedManager = API()
    private var sessionManager = SessionManager()
    private init() { }
    
    
    
    fileprivate let encoding = JSONEncoding.default
    
    func getUsers(sucees:@escaping ((_ status: Model)-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        
        let endpoint = "https://api.publicapis.org/entries"
        sessionManager.request(endpoint, method: .get,encoding: JSONEncoding.default).responseData { (response) in
            let result = response.result
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode(Model.self, from: data)
                        sucees(responseArray)
                    } catch  {
                        errorHandler(true)
                    }
                case .failure(_ ):
                    errorHandler(true)
            }
        }
    }
}
