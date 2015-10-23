//
//  ServiceRequest.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON

class ServiceRequest: NSObject {

    static let sharedInstance = ServiceRequest()


    enum DataStatus : Int {
        case NotReady
        case Ready
        case Error

    }

//    var manager = Alamofire.Manager.sharedInstance


}
