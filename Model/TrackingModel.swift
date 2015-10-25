//
//  TrackingModel.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class TrackingModel: Object {
    dynamic var order = ""
    dynamic var state = ""
    dynamic var label = ""
    dynamic var value = ""

}

