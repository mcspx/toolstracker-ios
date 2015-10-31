//
//  Config.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit

class Config: NSObject {
    static let sharedInstance = Config()
    let DEFAULT_PATH = "http://api.echeck-tools.com"
    let saveURLKey = "saveURLKey"
    var tracking:String! = ""
    var mainPath:String! = ""


    override init() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        var url = ""
        if let checkUrl = userDefault.objectForKey(self.saveURLKey) as? String{
            url = checkUrl
        }
        else{
            url = DEFAULT_PATH
        }


        mainPath = url
        tracking = "\(url)/tracking"





    }

}


