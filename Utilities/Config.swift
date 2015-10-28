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
    let saveURLKey = "saveURLKey"
    var tracking:String! = ""


    override init() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let url = userDefault.objectForKey(self.saveURLKey) as? String{
            tracking = "\(url)/tracking"
        }
        else{
            tracking = "http://api.echeck-tools.com/tracking"
        }
    }
    
}


