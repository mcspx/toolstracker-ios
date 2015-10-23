//
//  ServiceRequest.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServiceRequest: NSObject {

    static let sharedInstance = ServiceRequest()


    enum DataStatus : Int {
        case NotReady
        case Ready
        case Error

    }

    var manager = Alamofire.Manager.sharedInstance


    func getTracking(ssid:String , callback:(DataStatus) -> Void){
        let param = ["ssid": ssid]
        print(Config.sharedInstance.tracking)
        manager.request(.POST, Config.sharedInstance.tracking, parameters: param)
            .response(completionHandler: {(request , response , responseData , error) in
                if(error != nil){
                    callback(.Error)
                }

                guard let dataDic = JSON(data: responseData!).dictionary else{
                    callback(.Error)
                    return
                }
                
                if(dataDic["resultCode"]!.int! == 200){
                    for trackDic in dataDic["resultData"]!.array!{
                        TrackingModel.shareInstance.appendTracking(trackDic["order"].int!, state: trackDic["state"].string!, label: trackDic["label"].string!, value: trackDic["value"].string!)
                    }
                    callback(.Ready)
                }else{
                    callback(.Error)
                }

            })

    }



}
