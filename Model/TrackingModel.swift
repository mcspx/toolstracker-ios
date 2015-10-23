//
//  TrackingModel.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit

class TrackingModel: NSObject {
     static let shareInstance = TrackingModel()
    var trackingList:Array<TrackingViewModel> = []

    func appendTracking(order:Int ,state:String ,label:String ,value:String){
        let tracking = TrackingViewModel()
        tracking.order = order
        tracking.state = state
        tracking.label = label
        tracking.value = value
        trackingList.append(tracking)
    }

}

class TrackingViewModel: NSObject {
    var order = 0
    var state = ""
    var label = ""
    var value = ""
}
