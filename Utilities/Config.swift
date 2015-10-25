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
    static let MAIN_PATH = "http://api.echeck-tools.com"
    var saveURLKey = "saveURLKey"
    var tracking = "\(MAIN_PATH)/tracking"
}
