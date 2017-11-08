//
//  ApiManager.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    // Instanciamos la clase
    let news = News()
    
    func loadApiNews(callback:@escaping (_ newsList: [News]?, _ message: String, _ error: Bool)->()) {
        // Confirmamos si tenemos conexión a internet
        if Reachability.isConnectedToNetwork(){
            Alamofire.request(urlEndpoint, method: HTTPMethod.get, parameters:nil,encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    // Enviamos los datos a mapear y guardar en CoreData
                    self.news.MappingNews(DataJson: json)
                    callback(self.news.getAllNews(),"", false)
                case .failure(let error):
                    callback(nil, "Error al conectarse al Servidor", true)
                }
            }
        } else {
            callback(self.news.getAllNews(),"", false)
        }
    }
    
}
