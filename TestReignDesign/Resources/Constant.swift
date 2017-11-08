//
//  Constant.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import Foundation

// URL ENDPOINT
let urlEndpoint = getURLApi()

func getURLApi() -> String {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        return dict["URL_API"] as! String
    }
    return ""
}

//SEGUES
let SHOW_WEB = "showWeb"

//CELLS
let NEWS_CELL = "newsCell"

// USERDEFAULTS
let STORYS_DELETED = "storysDeleted"
