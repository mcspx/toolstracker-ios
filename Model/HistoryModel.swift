//
//  HistoryModel.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/24/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryModel: Object {
    let tracking = List<TrackingModel>()
}