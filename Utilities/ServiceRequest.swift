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
import RealmSwift
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
                    let history = HistoryModel()
                    for trackDic in dataDic["resultData"]!.array!{
                        var tempValue = ""
                        if let order = trackDic["order"].int ,
                           let state = trackDic["state"].string,
                           let label = trackDic["label"].string{

                            if let valueTrack = trackDic["value"].string{
                                tempValue = valueTrack
                            }
                            else{
                                tempValue = "\(trackDic["value"].int!)"
                            }
                            
                            let tracking = TrackingModel()
                            tracking.order = "\(order)"
                            tracking.state = state
                            tracking.label = label
                            tracking.value = tempValue
                            history.tracking.append(tracking)

                        }
                        else{
//                            callback(.Error)
                        }
                    }

                    let realm = try! Realm()
                    try! realm.write({
                        realm.add(history)
                    })
                     callback(.Ready)

                }else{
                    callback(.Error)
                }

            })

    }



}
